 classdef StudentDatabase
    properties
        Students % Array of Student objects
    end
    
    methods
        % Constructor to initialize the Students array
        function obj = StudentDatabase()
            obj.Students = Student.empty; % Initialize as an empty array of Student objects
        end
        
        % Method to Add New Student
        function obj = addStudent(obj, student)
            obj.Students(end + 1) = student; % Add a Student object to the array
        end
        
        % Method to Find Student by ID
        function student = findStudentByID(obj, id)
            student = [];
            for i = 1:length(obj.Students)
                if obj.Students(i).ID == id
                    student = obj.Students(i);
                    break;
                end
            end
            if isempty(student)
                error('Student with ID %d not found.', id);
            end
        end
        
        % Method to Get List of Students by Major
        function studentsByMajor = getStudentsByMajor(obj, major)
            studentsByMajor = obj.Students(strcmp({obj.Students.Major}, major));
        end
        
        % Method to Save Database to a File
        function saveToFile(obj, filename)
            try
                save(filename, 'obj');
            catch
                error('Error saving to file. Please check the filename and permissions.');
            end
        end
    end
    
    methods(Static)
        % Static Method to Load Database from a File
        function obj = loadFromFile(filename)
            try
                loadedData = load(filename);
                obj = loadedData.obj;
            catch
                error('Error loading file. Make sure the file exists and is a valid .mat file.');
            end
        end
    end
end
