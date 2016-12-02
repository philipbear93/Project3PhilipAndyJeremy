%% Project 3 Pseudo-Code
% This program contains no actual program code but is rather a template for
% code structuring


%% General steps for a given time step
% STEP 1
% From the known values of D0 and Dp0 find Dpp0

% STEP 2
% Select an appropriate dt, gamma and beta

% STEP 3
% Calculate Dn1 using Dnplus1

% STEP 4
% Calculate Dpn1 and Dppn1 using Dpnplus1 and Dppnplus1 respectively

% STEP 5
% Lather, Rinse, Repeat


%% General code structure

% Input K and M matrices from problem statement
% Input R and duration from problem statement

% Calculate C from K, M and a given Zeta using Cmatrix

% Calculate Dpp0 using a finite difference

% Select time step
% Select gamma
% Select beta

% Begin time for loop
    % Begin if statement, check if current time is less than force duration
        % Call Dnplus1 using input R
    % Begin else statement
        % Call Dnplus1 using R=[0]
    % end if/else block
    % Call Dpnplus1 using current Dn1
    % Call Dppnplus1 using current Dn1
    % Store Dn1, Dpn1, Dppn1 in time history array
    % Store current time in time array
    % Overwrite Dn Dpn and Dppn values with Dn1 Dpn1 and Dppn1 for next
    % loop
    % Update current time for next loop
% end time for block

% Plot D vs time
% Plot Dp vs time
% Plot Dpp vs time
