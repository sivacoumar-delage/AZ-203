# Retrieve data from blob storage

## Lab 1: List all the blobs in a container

:stopwatch: 5 minutes

#### Task 1: Open the solution BlobStorageSample in Visual Studio

#### Task 2: Comment the call to the UploadFileToBlobStorageAsync method

#### Task 3: Call the following method in the main method and implement the method

    ```csharp
    ListFilesFromBlobStorageAsync(connectionstring, "az203-blob-storage")
        .GetAwaiter()
        .GetResult();
    ```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task ListFilesFromBlobStorageAsync(
        string storageAccountConnectionString,
        string blobContainer)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(null);
        foreach (var blob in resultSegment.Results)
            Console.WriteLine(blob.Uri);
    }
    ```

</details>

#### Task 4: Test the method by debugging the solution

## Lab 2: Read the text files content and download all the blobs from the az203-blob-storage container to C:\Temp\DownloadedBlobs

:stopwatch: 10 minutes

#### Task 1: Read text files content

Call the following method in the main method and implement the method

```csharp
ReadFilesAsync(
    connectionstring,
    "az203-blob-storage",
    "*.txt")
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task ReadFilesAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string filesPattern)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(null);

        var blobs = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob =>
            Regex
            .Match(
                Path.GetFileName(blob.Uri.LocalPath),
                filesPattern.Replace("*", ".*"))
            .Success
            )
            .ToList();

        foreach (var blob in blobs)
        {
            Console.WriteLine(blob.Name);
            await ReadBlobContentAsync(container, blob);
        }
    }
    ```

1. Implement the *ReadBlobContentAsync* method as follow:

    ```csharp
    private static async Task ReadBlobContentAsync(
        CloudBlobContainer container, 
        CloudBlockBlob blob)
    {
        var cloudBlob = container.GetBlobReference(blob.Name);

        MemoryStream stream = new MemoryStream();
        await cloudBlob.DownloadToStreamAsync(stream);

        using (var streamReader = new StreamReader(stream))
        {
            stream.Position = 0;
            Console.WriteLine(streamReader.ReadToEnd());
        }
    }
    ```

</details>

#### Task 2: Download files to local computer

Call the following method in the main method and implement the method

```csharp
DownloadFilesAsync(
    connectionstring,
    "az203-blob-storage",
    "*",
    @"C:\Temp\DownloadedBlobs")
    .GetAwaiter()
    .GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the method as follow:

    ```csharp
    public static async Task DownloadFilesAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string filesPattern,
        string targetDirectoryPath)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

        var resultSegment = await container.ListBlobsSegmentedAsync(null);

        var blobs = resultSegment
            .Results
            .Cast<CloudBlockBlob>()
            .Where(blob =>
            Regex
            .Match(
                Path.GetFileName(blob.Uri.LocalPath),
                filesPattern.Replace("*", ".*"))
            .Success
            )
            .ToList();

        foreach (var blob in blobs)
            await DownloadBlobContentAsync(container, blob, targetDirectoryPath);
    }
    ```

1. Implement the *DownloadBlobContentAsync* method as follow:

    ```csharp
    private static async Task DownloadBlobContentAsync(
        CloudBlobContainer container,
        CloudBlockBlob blob,
        string targetDirectoryPath)
    {
        var cloudBlob = container.GetBlobReference(blob.Name);

        string targetFilePath = Path.Combine(targetDirectoryPath, cloudBlob.Name);
        await cloudBlob.DownloadToFileAsync(targetFilePath, FileMode.Create);
    }
    ```

</details>