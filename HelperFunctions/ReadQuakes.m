function quakes = ReadQuakes(useRecentData,tfinal,tstart)
% READQUAKES Read earthquake data from web API
% Function to import recent earthquake data or load previously imported data.

% Validate input arguments and provide defaults
arguments
   useRecentData (1,1) logical {mustBeNumericOrLogical} = false;
   tfinal (1,1) datetime {mustBeNonempty} = datetime("now") - hours(8); 
   tstart (1,1) datetime {mustBeNonempty} = tfinal - caldays(30);   
end

% Update format for API call
tstart.Format = "dd-MMM-uuuu HH:mm:ss";
tfinal.Format = "dd-MMM-uuuu HH:mm:ss";

% Read earthquake data over the time specified
if useRecentData
    
    daterange = "starttime="+string(tstart)+"&endtime="+string(tfinal);
    opts = weboptions("Timeout",25);
    try
        quakes = webread("https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&"+...
            daterange,opts);
        % Convert the data types and rearrange
        quakes = PreprocessQuakes(quakes);
        
        % Load historic data if selected (or on read error)
    catch
        x = load("Feb2018.mat");
        quakes = x.quakes;
    end
else
    x = load("Feb2018.mat");
    quakes = x.quakes;
end

% Preprocess the textual location data
quakes = PreprocessLocations(quakes);
end
