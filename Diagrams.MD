```mermaid
graph TD
    A[End user uploads an image] --> B[ECS app instance generates instructions]
    B --> C[Instructions are saved in JSON file]
    C --> D[JSON file is uploaded to S3]
    D --> E[ECS app submits a job to SQS work queue]
    E --> F[EC2 worker reads the message from the queue]
    F --> G[Worker generates the intermediate image]
    G --> H[Intermediate image is uploaded to S3]
    H --> I[Worker sends SNS notification]
    I --> J[Lambda worker reads SNS notification]
    J --> K[Lambda worker finds JSON file]
    K --> L[Lambda worker downloads JSON file from S3]
    L --> M[Lambda worker submits instructions to SQS queue]
    M --> N[Image processing worker reads message from SQS queue]
    N --> O[Worker applies instructions to intermediate image]
    O --> P[Worker creates a derivative image]
    P --> Q[Derivative image is uploaded to S3]
````


```mermaid
graph TD
graph TD
    A[End user uploads an image] --> B[ECS app instance generates instructions]
    B --> C[Instructions are saved in JSON file]
    C --> D[JSON file is uploaded to S3]
    D --> E[ECS app submits a job to SQS work queue]
    E --> F[EC2 worker reads the message from the queue]

    subgraph EC2 Worker
    F --> G[Worker generates the intermediate image]
    G --> H[Intermediate image is uploaded to S3]
    H --> I[Worker sends SNS notification]
    end

    I --> J[Lambda worker reads SNS notification]

    subgraph Lambda Worker
    J --> K[Lambda worker finds JSON file]
    K --> L[Lambda worker downloads JSON file from S3]
    L --> M[Lambda worker submits instructions to SQS queue]
    end

    M --> N[Image processing worker reads message from SQS queue]

    subgraph Image Processing Worker
    N --> O[Worker applies instructions to intermediate image]
    O --> P[Worker creates a derivative image]
    P --> Q[Derivative image is uploaded to S3]
    end

```
