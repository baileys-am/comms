%DEMODULATOR
    %   Description: Base class for a demodulator.
    
%VERSIONING
    %   Author: Steven Cantrell
    %   Date Created: 2/25/2017
    %   Version: 1
    %       (2/25/2017) Initial commit.
    
classdef (Abstract) demodulator
%% Abstract Methods
    methods(Abstract)
        % Deodulates mapped symbols into a bitstream
        bistream = Demodulate(obj, symbols)
    end
%% Abstract Methods
end