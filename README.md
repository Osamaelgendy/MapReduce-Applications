# MapReduce-Applications

## Project Overview
This project demonstrates the use of Hadoop MapReduce with both Java and Python implementations. The project focuses on comparing the data transferred to reducers when using a combiner versus not using a combiner. Additionally, the project was set up on a Linux machine using Docker for a streamlined development and testing environment.

---

## Project Structure

```
/my-mapreduce-project
│── Dockerfile
├── /java
│   ├── /src
│   │   ├── /main
│   │   │   ├── /java
│   │   │   │   ├── /com
│   │   │   │   │   ├── /yourpackage
│   │   │   │   │   │   ├── StringPairDriver.java
│   │   │   │   │   │   ├── StringPairMapper.java
│   │   │   │   │   │   ├── StringPairReducer.java
│   │   │   │   │   │   └── StringPairWritable.java
│   │   ├── /resources
│   │   │   ├── /input
│   │   │   └── /output
│   │   ├── pom.xml (or build.gradle)
│   │   
│
├── /python
│   ├── /Indus_data_partition&customclass
│   │   ├── /code
│   │   ├── /input
│   │   ├── /logs
│   │   └── /outputs
│   ├── /Indus_data_simple_count
│   │   ├── /code
│   │   ├── /input
│   │   ├── /logs
│   │   └── /outputs
│   ├── requirements.txt
│
├── /docs
│   ├── README.md
│   └── report_comparison.md
│
├── /tests
│   ├── /java_tests
│   │   ├── StringPairDriverTest.java
│   │   ├── StringPairMapperTest.java
│   │   ├── StringPairReducerTest.java
│   │   └── StringPairWritableTest.java
│   ├── /python_tests
│   │   ├── test_partition_customclass.py
│   │   └── test_simple_count.py
│
└── .gitignore
```

---

## Project Setup

### 1. Setting Up Hadoop Using Docker
The Hadoop environment was configured on a Linux machine using a custom Dockerfile. This ensures a consistent and portable setup.

Steps:
1. Create Dockerfile containing all the dependencies for your linux machine that hosts hadoop in a pseudo distributed mode.
   **Dockerfile**: Defines the environment for running hadoop on a linux machine.
   
2. Build the Docker image:
   ```bash
   docker build -t custom-hadoop-ubuntu .
   ```
3. Run the Hadoop container:
   ```bash
   docker run -it -p 8088:8088 -p 9870:9870 -p 19888:19888 custom-hadoop-ubuntu:latest
   ```

### 2. Java Implementation
The `java` directory contains the implementation of the MapReduce task in Java.

- **StringPairDriver.java**: Main driver class for the MapReduce task.
- **StringPairMapper.java**: Implements the Mapper logic.
- **StringPairReducer.java**: Implements the Reducer logic.
- **StringPairWritable.java**: Defines a custom writable for composite keys.
- **pom.xml**: Maven configuration for building and managing dependencies.

To compile and run the Java application:
```bash
cd java/src/main/java
mvn clean package
hadoop jar target/your-jar-file.jar com.yourpackage.StringPairDriver /resources/input /resources/output
```

### 3. Python Implementation
The `python` directory includes two main tasks for processing data:

- **Indus_data_partition&customclass**: Handles data partitioning and uses a custom class.
  - **Code**: Python scripts for the task.
  - **Input**: Input data files.
  - **Logs**: Log files generated during execution.
  - **Outputs**: Processed output data.

- **Indus_data_simple_count**: Implements a simple count task.
  - **Code**: Python scripts for the task.
  - **Input**: Input data files.
  - **Logs**: Log files generated during execution.
  - **Outputs**: Processed output data.


Run the tasks:
```bash
python python/task_with_combiner/task_with_combiner.py
python python/task_without_combiner/task_without_combiner.py
```

### 4. Documentation
- **README.md**: This file, providing an overview of the project.
- **report_comparison.md**: Detailed report comparing data transferred to the reducers with and without the combiner.

### 5. Testing
The `tests` directory contains unit tests for both Java and Python implementations.

Run Java tests:
```bash
cd tests/java_tests
mvn test
```

Run Python tests:
```bash
pytest tests/python_tests
```

---

## Results and Insights
- Using a combiner significantly reduced the amount of data transferred to the reducers.
- The performance comparison is documented in `docs/report_comparison.md`.

---

## Future Enhancements
- Add additional MapReduce tasks for more complex datasets.
- Implement a Spark-based version for comparison.
- Enhance testing coverage and add integration tests.

---

## Contributions
Contributions are welcome! Feel free to fork the repository and submit a pull request.

---

## License
This project is licensed under the MIT License. See `LICENSE` for details.

