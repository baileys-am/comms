%QAMMODEMTEST
    %   Description: Test class for QAM modem.
    
%VERSIONING
    %   Author: Steven Cantrell
    %   Date Created: 2/25/2017
    %   Changelog:
    %     (2/25/2017) Initial commit.
    %     (2/25/2017) Implemented and tested Modulate/Demodulate test
    %       method.
    %     (2/28/2017) Renamed. Merged modemTest, qammodTest, and
    %       qamdemodTest. Updated tests for multiple modulation orders.

classdef qammodemTest < matlab.unittest.TestCase
%% Test Methods
    methods (Test)
        function ModulateTest(testCase)
            Nsym = 1000;
            Mrange = 2.^(2:2:8);
            m = comms.modem.qammodem;
            m.DataType = 'bit';
            
            for i = 1:numel(Mrange)
                M = Mrange(i);
                m.Alphabet.M = M;
                bitstream = randi([0 1], 1, Nsym * log2(M));
                symbolMappings = comms.bin2dec(bitstream, log2(m.Alphabet.M));
                
                % Verify modulation
                actSolution = m.Modulate(bitstream);
                expSolution = m.Alphabet.Constellation(comms.findi(m.Alphabet.SymbolMapping, symbolMappings));
                testCase.verifyEqual(actSolution, expSolution);
            end
        end
        
        function DeodulateTest(testCase)
            Nsym = 1000;
            Mrange = 2.^(2:2:8);
            m = comms.modem.qammodem;
            m.DataType = 'bit';
            
            for i = 1:numel(Mrange)
                M = Mrange(i);
                m.Alphabet.M = M;
                bitstream = randi([0 1], 1, Nsym * log2(M));
                symbolMappings = comms.bin2dec(bitstream, log2(m.Alphabet.M));
                symbols = m.Alphabet.Constellation(comms.findi(m.Alphabet.SymbolMapping, symbolMappings));
                
                % Verify demodulation
                actSolution = m.Demodulate(symbols);
                expSolution = bitstream;
                testCase.verifyEqual(actSolution, expSolution);
            end
        end
        
        function LoopbackTest(testCase)
            Nsym = 1000;
            Mrange = 2.^(2:2:8);
            m = comms.modem.qammodem;
            m.DataType = 'bit';
            
            for i = 1:numel(Mrange)
                M = Mrange(i);
                m.Alphabet.M = M;
 
                % Validate loopback on modem
                expSolution = randi([0 1], 1, Nsym * log2(M));
                actSolution = m.Demodulate(m.Modulate(expSolution));
                testCase.verifyEqual(actSolution, expSolution);
            end
        end
    end
%% Test Methods
end