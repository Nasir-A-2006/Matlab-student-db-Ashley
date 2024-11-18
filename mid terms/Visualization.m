classdef Visualization
    methods(Static)
        % Method to plot GPA distribution as a histogram
        function plotGPADistribution(students)
            % Extract GPA values from students
            gpas = [students.GPA];
            
            % Create the histogram for GPA distribution
            figure;
            histogram(gpas, 'BinWidth', 0.25); % Adjust BinWidth if needed
            title('GPA Distribution');
            xlabel('GPA');
            ylabel('Number of Students');
        end
        
        % Method to plot average GPA by major
        function plotAverageGPAByMajor(students)
            % Extract majors and GPAs
            majors = {students.Major};
            uniqueMajors = unique(majors);
            averageGPAs = zeros(1, length(uniqueMajors));
            
            % Calculate the average GPA for each major
            for i = 1:length(uniqueMajors)
                currentMajor = uniqueMajors{i};
                majorGPAs = [students(strcmp(majors, currentMajor)).GPA];
                averageGPAs(i) = mean(majorGPAs);
            end
            
            % Create the bar chart for average GPA by major
            figure;
            bar(categorical(uniqueMajors), averageGPAs);
            title('Average GPA by Major');
            xlabel('Major');
            ylabel('Average GPA');
        end
        
        % Method to plot age distribution as a histogram
        function plotAgeDistribution(students)
            % Extract Age values from students
            ages = [students.Age];
            
            % Create the histogram for Age distribution
            figure;
            histogram(ages, 'BinWidth', 1); % Adjust BinWidth if needed
            title('Age Distribution');
            xlabel('Age');
            ylabel('Number of Students');
        end
    end
end
