
% this script will read segmentation point in unit second and plot 
% them with the pattern
% ADD : CALCULATE FIND THE PERFORMANCE FOR ALL


%open fail
Filename = {'0075_a', '0075_g', '1206_a', '1206_g', '2433_a', '2433_g', '3630_a', '3630_g', '4137_a', '4137_g', '5580_a', '5580_g', '6255_a', '6255_g', '7565_a', '7565_g', '8299_a', '8299_g', '9472_a', '9472_g'};
Folder1='./pattern/';    % folder of the pattern
Folder2='./refpoint/';   % folder consist the reference point files
FOut = fopen('./result/record.txt','wt')
Fs = 16000; % sampling rate



%Experimetal parameters
Time = 0.10;
Threshold = 2.0;
%winsize = 256;
%winsize = 250;
%winsize = 300;
winsize = 350;
%winsize = 956;

%printf the parameters infomations in the file
%fprintf(FOut,' Information on all %d patterns',n);
fprintf(FOut,'\tTime Tolerence = %1.2f',Time);
fprintf(FOut,'\tThreshold = %1.2f',Threshold);
fprintf(FOut,'\tWin Size = %d\n\n',winsize);
fprintf(FOut,'\tRate-->  \tP(M)\tP(O)\tP(I)\n');


N = 0;   % total nummber of auto segmentation points
P =0;    % total number of manual / reference segmetation points;
M = 0;   % ttal number of match;
G=0; 
for n=1:20 % 10 files
    %open reference points per pattern (points in seconds)
    FILE1 =strcat(Folder2,char(Filename(n)),'.SEG');
    f1 = fopen(FILE1,'r');
    S1 = fscanf(f1,'%g');
    S1 = S1 * Fs;   % convert to sample unit
      
    %open TEST file per pattern
    FILE2 = strcat(Folder1,char(Filename(n)),'.wav');
    Y = audioread(FILE2);
    
    
    %calculate the  automatic segmentation / call function
   
    
    %[S2 K] = Algorithm1(Y,Threshold,winsize);
    [S2 K] = Algorithm2(Y,Threshold,winsize);
   
    
    % K= number of segmentation point
    % segmentation point
    
    
   %%%% Z = ZeroX(Y, winsize);       
   %%%% G = G + Z;
    
    %plot the file with segmentation points (both reference and manual)
       figure('Name',char(Filename(n)),'NumberTitle','on')
       PlotSegment2(Y,S1,S2);         
     
    % find total N
      N = N + K;
      
    %find Match and find total M
     Match = Find_Match(S1,S2,Time);
     M = M + Match;

     % print into file individual perfromance
     % 8 is number of reference segmentation points per pattern
     PM = Match/8; % Match rate 
     PO = (8-Match)/8 % Omission Rate
     PI = (K-Match)/K;  % Insertion Rate
      
     fprintf(FOut,'\tPattern %d\t%2.2f \t%2.2f \t%2.2f\n',n,PM,PO,PI);
     
     
    %empty variables
    clear Y;
    clear S1;
    clear S2;
end
      
             
   % find total P 
        %For each pattern P=8 so, total P = 8*n 
        % where n is number of pattern tested
        P = 8*n;
        
         
   %calculate the performance
    MatchRate     = M/P;        
    OmissionRate  =(P-M)/P;
    InsertionRate =(N-M)/N;
    
    
   %print into file
    fprintf(FOut,'\n\nTotal P: %d Total N: %d Total M: %d\n',P,N,M);      
    fprintf(FOut,'Total Match Rate = %2.2f\n',MatchRate);
    fprintf(FOut,'Total Omission Rate = %2.2f\n',OmissionRate);
    fprintf(FOut,'Total Insertion Rate = %2.2f\n',InsertionRate);
    
    fclose(f1);   
    fclose(FOut);
    disp('end');
 
 
    