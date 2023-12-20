CREATE TABLE station (
  station_id SMALLINT NOT NULL, 
  station_name TEXT, 
  lat REAL, 
  long REAL, 
  dock_count SMALLINT, 
  city TEXT, 
  installation_date DATE, 
  zip_code TEXT, 
  PRIMARY KEY (station_id)
);

CREATE TABLE trip (
  id INTEGER NOT NULL, 
  start_time TIMESTAMP, 
  start_station_name TEXT, 
  start_station_id SMALLINT, 
  end_time TIMESTAMP, 
  end_station_name TEXT, 
  end_station_id SMALLINT, 
  bike_id SMALLINT, 
  PRIMARY KEY (id), 
  FOREIGN KEY (start_station_id) REFERENCES station(station_id), 
  FOREIGN KEY (end_station_id) REFERENCES station(station_id)
);

CREATE TABLE weather (
  date DATE NOT NULL, 
  max_temp REAL, 
  mean_temp REAL, 
  min_team REAL, 
  max_visibility_miles REAL, 
  mean_visibility_miles REAL, 
  min_visibility_miles REAL, 
  max_wind_speed_mph REAL, 
  mean_wind_speed_mph REAL,
  cloud_cover REAL, 
  events TEXT, 
  wind_dir_degrees REAL, 
  zip_code TEXT NOT NULL, 
  PRIMARY KEY (date, zip_code)
);
