# MapReduce-Applications

## Project Overview
This project demonstrates the use of Hadoop MapReduce with both Java and Python implementations. The project focuses on comparing the data transferred to reducers when using a combiner versus not using a combiner. Additionally, the project was set up on a Linux machine using Docker for a streamlined development and testing environment.

---

## Project Structure

```
/my-mapreduce-project
│
├── /java
│   ├── /src
│   │   ├── /main
│   │   │   ├── /java
│   │   │   │   ├── /com
│   │   │   │   │   ├── /yourpackage
│   │   │   │   │   │   ├── MapReduceTask.java
│   │   │   │   │   │   ├── CustomWritable.java
│   │   │   │   │   │   ├── CompositeKey.java
│   │   │   │   │   │   └── OtherClasses.java
│   │   ├── /resources
│   │   │   ├── /input
│   │   │   └── /output
│   │   ├── pom.xml (or build.gradle)
│
├── /python
│   ├── /task_with_combiner
│   │   ├── task_with_combiner.py
│   │   └── /data
│   │       ├── input_file
│   │       └── output_file
│   ├── /task_without_combiner
│   │   ├── task_without_combiner.py
│   │   └── /data
│   │       ├── input_file
│   │       └── output_file
│   ├── /utils
│   │   └── helper_functions.py
│   ├── requirements.txt
│
├── /docs
│   ├── README.md
│   └── report_comparison.md
│
├── /tests
│   ├── /java_tests
│   │   ├── MapReduceTaskTest.java
│   │   └── CustomWritableTest.java
│   ├── /python_tests
│   │   ├── test_task_with_combiner.py
│   │   └── test_task_without_combiner.py
│
└── .gitignore
```

---

## Project Setup

### 1. Setting Up Hadoop Using Docker
The Hadoop environment was configured on a Linux machine using a custom Dockerfile. This ensures a consistent and portable setup.

Steps:
1. Build the Docker image:
   ```bash
   docker build -t hadoop-environment .
   ```
2. Run the Hadoop container:
   ```bash
   docker run -d -p 8088:8088 -p 50070:50070 --name hadoop-container hadoop-environment
   ```
3. Access the Hadoop UI at `http://localhost:8088` (Resource Manager) and `http://localhost:50070` (NameNode).

### 2. Java Implementation
The `java` directory contains the implementation of the MapReduce task in Java.

- **CustomWritable.java**: Defines a custom writable for composite keys.
- **MapReduceTask.java**: Implements the Map and Reduce logic.
- **pom.xml**: Maven configuration for building and managing dependencies.

To compile and run the Java application:
```bash
cd java/src/main/java
mvn clean package
hadoop jar target/your-jar-file.jar com.yourpackage.MapReduceTask /resources/input /resources/output
```

### 3. Python Implementation
The `python` directory includes implementations of the MapReduce tasks in Python with and without a combiner for comparison.

- **task_with_combiner.py**: Implements the MapReduce logic using a combiner.
- **task_without_combiner.py**: Implements the MapReduce logic without a combiner.
- **helper_functions.py**: Contains utility functions used in the Python tasks.
- **requirements.txt**: Lists the Python dependencies.

Install Python dependencies:
```bash
pip install -r python/requirements.txt
```

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

