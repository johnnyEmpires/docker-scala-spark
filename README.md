# docker-scala-spark
run scala-spark in a docker container

## Setup

1. clone then change directory to this repository
```
git clone https://github.com/johnnyEmpires/docker-scala-spark.git

cd docker-scala-spark
```

2. Build docker image

```
docker build -t scala-spark-image .
```

3. Create and start the container

```
docker run -dt --name scala-spark-container scala-spark-image
```

4. Access the container

```
docker exec -it scala-spark-container /bin/ash
```

**Notes:** since the base image used is `Alpine` linux, use `ash` instead of `bash`. 

5. Run spark

```
~ # spark-shell
21/06/26 04:54:49 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://1bfd169dd9d1:4040
Spark context available as 'sc' (master = local[*], app id = local-1624683295025).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.1.2
      /_/

Using Scala version 2.12.10 (OpenJDK 64-Bit Server VM, Java 1.8.0_151)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```

