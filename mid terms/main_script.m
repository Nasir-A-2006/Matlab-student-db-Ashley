
% Initialize database
db = StudentDatabase();

% sample students (can be removed for a clean slate)
student1 = Student(1, 'Alice Johnson', 20, 3.5, 'Computer Science');
student2 = Student(2, 'Bob Smith', 21, 3.8, 'Mathematics');
student3 = Student(3, 'Charlie Brown', 19, 3.2, 'Physics');
student4 = Student(4, 'Diana Prince', 22, 3.6, 'Computer Science');
db = db.addStudent(student1);
db = db.addStudent(student2);
db = db.addStudent(student3);
db = db.addStudent(student4);

% Save and load database (for persistence)
db.saveToFile('student_database.mat');
db = db.loadFromFile('student_database.mat');

while true
    % Display the main menu initially
    fprintf('\nChoose an action:\n');
    fprintf('1. Search by Student ID\n');
    fprintf('2. Search by Major\n');
    fprintf('3. Add a New Student\n');
    fprintf('4. Edit an Existing Student\n');
    fprintf('5. Delete a Student\n');
    fprintf('6. Exit\n');
    
    % Collect user input for the action choice
    choice = input('Enter your choice (1, 2, 3, 4, 5, or 6): ');

    % Clear the screen after the user input to replace old output with new
    clc;

    switch choice
        case 1
            % Search by ID
            studentID = input('Enter Student ID: ');
            try
                student = db.findStudentByID(studentID);
                student.displayInfo();  % Display student info
            catch ME
                fprintf('Error: %s\n', ME.message);
            end
            promptBack();

        case 2
            % Search by Major
            majors = unique({db.Students.Major});
            fprintf('Select a major from the list below:\n');
            for i = 1:length(majors)
                fprintf('%d. %s\n', i, majors{i});
            end
            majorChoice = input('Enter your choice (1 to %d): ', 's');
            majorChoice = str2double(majorChoice);  % Convert to number

            if majorChoice >= 1 && majorChoice <= length(majors)
                majorToSearch = majors{majorChoice};
                studentsByMajor = db.getStudentsByMajor(majorToSearch);

                if ~isempty(studentsByMajor)
                    fprintf('Students with the major %s:\n', majorToSearch);
                    for i = 1:length(studentsByMajor)
                        studentsByMajor(i).displayInfo();
                    end
                else
                    fprintf('No students found with the major: %s\n', majorToSearch);
                end
            else
                fprintf('Invalid choice. Please select a valid option.\n');
            end
            promptBack();

        case 3
            % Add a New Student
            fprintf('Enter details for the new student:\n');
            newID = input('Enter Student ID: ');
            newName = input('Enter Student Name: ', 's');
            newAge = input('Enter Student Age: ');
            newGPA = input('Enter Student GPA: ');
            newMajor = input('Enter Student Major: ', 's');

            newStudent = Student(newID, newName, newAge, newGPA, newMajor);
            db = db.addStudent(newStudent);

            db.saveToFile('student_database.mat');
            fprintf('New student added successfully!\n');
            promptBack();

        case 4
            % Edit an Existing Student
            fprintf('Select a student to edit:\n');
            for i = 1:length(db.Students)
                fprintf('%d. %s (ID: %d)\n', i, db.Students(i).Name, db.Students(i).ID);
            end

            editChoice = input('Enter the number of the student to edit: ');

            if editChoice >= 1 && editChoice <= length(db.Students)
                selectedStudent = db.Students(editChoice);
                fprintf('Current details for %s (ID: %d):\n', selectedStudent.Name, selectedStudent.ID);
                selectedStudent.displayInfo();

                fprintf('Select a field to edit:\n');
                fprintf('1. Name\n');
                fprintf('2. Age\n');
                fprintf('3. GPA\n');
                fprintf('4. Major\n');
                editField = input('Enter your choice (1-4): ');

                switch editField
                    case 1
                        newName = input('Enter new name: ', 's');
                        selectedStudent.Name = newName;
                    case 2
                        newAge = input('Enter new age: ');
                        selectedStudent.Age = newAge;
                    case 3
                        newGPA = input('Enter new GPA: ');
                        selectedStudent.GPA = newGPA;
                    case 4
                        newMajor = input('Enter new major: ', 's');
                        selectedStudent.Major = newMajor;
                    otherwise
                        fprintf('Invalid choice.\n');
                end

                db.saveToFile('student_database.mat');
                fprintf('Student information updated successfully!\n');
            else
                fprintf('Invalid student selection.\n');
            end
            promptBack();

        case 5
            % Delete a Student
            fprintf('Select a student to delete:\n');
            for i = 1:length(db.Students)
                fprintf('%d. %s (ID: %d)\n', i, db.Students(i).Name, db.Students(i).ID);
            end

            deleteChoice = input('Enter the number of the student to delete: ');

            if deleteChoice >= 1 && deleteChoice <= length(db.Students)
                db.Students(deleteChoice) = [];  % Remove student from the list
                db.saveToFile('student_database.mat');
                fprintf('Student deleted successfully!\n');
            else
                fprintf('Invalid student selection.\n');
            end
            promptBack();

        case 6
            % Exit
            fprintf('Exiting the program.\n');
            break;

        otherwise
            fprintf('Invalid choice. Please enter 1, 2, 3, 4, 5, or 6.\n');
            promptBack();
    end
end

% Helper function for "Back" functionality
function promptBack()
    % Prompt the user if they want to go back to the main menu
    backChoice = input('Press 0 to go back to the main menu, or type "exit" to quit: ', 's');
    if strcmpi(backChoice, 'exit')
        fprintf('Exiting the program.\n');
        return;
    elseif strcmp(backChoice, '0')
        return;
    end
end
