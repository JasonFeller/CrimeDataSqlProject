select * from crime;


-- Add new columns for updated date and time
ALTER TABLE crime
ADD [OffenseStartDate] Date,
	[OffenseStartTime] Time,
	[OffenseEndDate] Date,
	[OffenseEndTime] Time,
	[ReportDate] Date,
	[ReportTime] Time;


-- Update the new date and time columns with data from the 'DateTime' columns
UPDATE crime
SET OffenseStartDate = Convert(date, [Offense Start Datetime]),
	OffenseStartTime = Convert(time, [Offense Start Datetime]),
	OffenseEndDate = Convert(date, [Offense End Datetime]),
	OffenseEndTime = Convert(time, [Offense End Datetime]),
	ReportDate = Convert(date, [Report Datetime]),
	ReportTime = Convert(time, [Report Datetime]);

-- Remove the original 'Offense Start DateTime' column
ALTER TABLE crime
DROP COLUMN [Offense Start DateTime],[Offense End DateTime],[Report DateTime];

-- Lets remove other columns we don't want in our table
ALTER TABLE crime
DROP COLUMN [Group A B],[Sector],[Beat],[Longitude],[Latitude];

-- Select all Null values for [Offense Code]
select * from crime 
where [Offense Code] is Null
order by Offense;

-- There are 18,000+ NULL values in [Offense Code], lets replace NULL values with the first 4 values from [Offense]
Update crime 
SET [Offense Code] = LEFT([offense],4)
WHERE [Offense Code] IS NULL;

-- Lets sort the data by report date, starting with the most recent
SELECT * from crime 
order by [ReportDate] desc;

-- Lets limit the results to only events from the year 2020
SELECT * from crime 
Where YEAR([ReportDate]) = 2020
order by [ReportDate] desc;

