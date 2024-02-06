

-- Creation of the Patients table to store patient profiles
-- This ensures data normalization by eliminating redundancy and facilitates data integrity.
CREATE TABLE Patients (
    PatientID SERIAL PRIMARY KEY, -- Auto-incremented primary key for unique patient identification
    Name VARCHAR(255) NOT NULL,   -- Patient name, NOT NULL constraint ensures data completeness
    DOB DATE,                     -- Date of birth of the patient
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')) -- Gender with check constraint for valid values
);

-- Creation of the SeizureEpisodes table to store information about seizure episodes
-- Includes references to the Patients table to maintain data integrity and normalization.
CREATE TABLE SeizureEpisodes (
    EpisodeID SERIAL PRIMARY KEY,  -- Auto-incremented primary key for unique seizure episode identification
    PatientID INT REFERENCES Patients(PatientID), -- Foreign key linking to the Patients table
    StartTime TIMESTAMP WITHOUT TIME ZONE, -- Start time of the seizure episode
    EndTime TIMESTAMP WITHOUT TIME ZONE,   -- End time of the seizure episode
    Type VARCHAR(100),                     -- Type of seizure
    Severity INT                           -- Severity of the seizure episode
);

-- Creation of the EEGReadings table to store EEG readings
-- Designed for high-volume inserts and rapid querying to facilitate real-time analysis.
CREATE TABLE EEGReadings (
    ReadingID SERIAL PRIMARY KEY, -- Auto-incremented primary key for unique EEG reading identification
    EpisodeID INT REFERENCES SeizureEpisodes(EpisodeID), -- Foreign key to link reading to a seizure episode
    Timestamp TIMESTAMP WITHOUT TIME ZONE, -- Timestamp of the EEG reading, crucial for time-series data
    DataPath VARCHAR(255)                  -- Path to the EEG data file, allows for efficient data retrieval
);

-- Creation of the Annotations table to store annotations on EEG readings
-- Annotations are crucial for providing context and additional information on EEG readings.
CREATE TABLE Annotations (
    AnnotationID SERIAL PRIMARY KEY, -- Auto-incremented primary key for unique annotation identification
    ReadingID INT REFERENCES EEGReadings(ReadingID), -- Foreign key to link annotation to a specific EEG reading
    Timestamp TIMESTAMP WITHOUT TIME ZONE,            -- Timestamp of the annotation
    AnnotationText TEXT                               -- Text of the annotation
);

-- Indexing strategies to expedite search queries, especially for time-series data
-- Indexes are crucial for improving query performance and are a part of optimizing the schema for scalability.
CREATE INDEX idx_patient_id ON SeizureEpisodes(PatientID);
CREATE INDEX idx_episode_id ON EEGReadings(EpisodeID);
CREATE INDEX idx_reading_timestamp ON EEGReadings(Timestamp);






