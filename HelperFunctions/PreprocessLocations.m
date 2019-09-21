function quakes = PreprocessLocations(quakes)
% PREPROCESSLOCATIONS Preprocess location strings
 
% In this case, we just want the country or state, which we can get from the 
% strings. 
quakes.Loc = extractAfter(quakes.place,",");
quakes.Loc = strip(quakes.Loc);

% If they didn't have a comma or space, they were left missing. Use the full 
% label in that case.
idx = ismissing(quakes.Loc);
quakes.Loc(idx) = quakes.place(idx);
idx = endsWith(quakes.Loc,"region");
quakes.Loc(idx) = erase(quakes.Loc(idx)," region");

% Now convert to categorical. 
quakes.Loc = categorical(quakes.Loc);

% Clean up some categories.
quakes.Loc = mergecats(quakes.Loc,["CA","California"],"California");
quakes.Loc = mergecats(quakes.Loc,["MX","B.C., MX","Mexico"],"Mexico");
end