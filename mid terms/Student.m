classdef Student
    properties
        ID
        Name
        Age
        GPA
        Major
    end
    
    methods
        % Constructor to initialize a Student object
        function obj = Student(id, name, age, gpa, major)
            if nargin > 0
                obj.ID = id;
                obj.Name = name;
                obj.Age = age;
                obj.GPA = gpa;
                obj.Major = major;
            end
        end
        
        % Method to Display Student Information
        function displayInfo(obj)
            fprintf('ID: %d\n', obj.ID);
            fprintf('Name: %s\n', obj.Name);
            fprintf('Age: %d\n', obj.Age);
            fprintf('GPA: %.2f\n', obj.GPA);
            fprintf('Major: %s\n\n', obj.Major);
        end
        
        % Method to Update GPA
        function obj = updateGPA(obj, newGPA)
            obj.GPA = newGPA;
        end
    end
end
