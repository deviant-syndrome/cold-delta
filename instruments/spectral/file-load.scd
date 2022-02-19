~loadPartials = { | fileName |
	var initialData;
	var basePath = thisProcess.nowExecutingPath.dirname;
	var cachedPath = basePath +/+ "cache" +/+ fileName;
	var csvPath = basePath +/+ fileName;

	var cacheExists = File.exists(cachedPath);

	if ( cacheExists,
		{
			initialData = Object.readArchive(cachedPath); },
		{
			initialData = CSVFileReader.readInterpret(csvPath);
			File.mkdir(PathName.new(cachedPath).pathOnly);
			initialData.writeArchive(cachedPath);
		}
	);
	initialData
}
