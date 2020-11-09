function quakes = PreprocessQuakes(quakes)
% PREPROCESSQUAKES Reorganize earthquake data

% Convert data types
quakes.time = datetime(quakes.time,...
    "InputFormat",'yyyy-MM-dd''T''HH:mm:ss.SSS''Z','TimeZone','UTC');
quakes = table2timetable(quakes);
quakes.type = categorical(quakes.type);
quakes = convertvars(quakes,["id","place"],"string");

% Select data of interest
quakes = quakes(:,["latitude","longitude","depth",...
    "mag","rms","place","type"]);
quakes = sortrows(quakes);
end