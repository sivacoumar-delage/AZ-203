# Implement blob leasing

## Lab 1: Implement blob leasing from a .NET Core application

:stopwatch: 5 minutes

This lab will be conducted on the BlobStorageSample solution.

#### Task 1: Acquire a new lease

Call the following methods in the main method and implement the method:

```csharp
string leaseId = AcquireBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    new TimeSpan(0, 0, leaseDurationinSeconds))
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease acquired on {blobName}: {leaseId}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();

Wait(leaseDurationinSeconds);

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **AcquireBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task<string> AcquireBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        TimeSpan leaseTime)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        return await blockBlob.AcquireLeaseAsync(leaseTime);
    }
    ```

1. Implement the **Wait** method as follow:

    ```csharp
    private static void Wait(int seconds)
    {
        Console.WriteLine($"Waiting {seconds} seconds...");
        Task.Delay(seconds * 1000)
            .GetAwaiter()
            .GetResult();
    }
    ```

</details>

#### Task 2: Display a blob lease status

<details>
<summary>Click here to display answers</summary>

1. Implement the **DisplayBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task DisplayBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.FetchAttributesAsync();

        Console.WriteLine($"\tLeaseDuration = {blockBlob.Properties.LeaseDuration}");
        Console.WriteLine($"\tLeaseState = {blockBlob.Properties.LeaseState}");
        Console.WriteLine($"\tLeaseStatus = {blockBlob.Properties.LeaseStatus}");
    }
    ```

</details>

#### Task 3: Renew an existing lease

Call the following methods in the main method and implement the **RenewBlobLeaseAsync** method:

```csharp
RenewBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    leaseId)
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease renewed on {blobName}: {leaseId}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **RenewBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task RenewBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string leaseId)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.RenewLeaseAsync(AccessCondition.GenerateLeaseCondition(leaseId));
    }
    ```

</details>

#### Task 4: Change the ID of an existing lease

Call the following methods in the main method and implement the **ChangeBlobLeaseAsync** method:

```csharp
leaseId = ChangeBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    leaseId)
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease changed on {blobName}: {leaseId}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **ChangeBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task<string> ChangeBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string leaseId)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        string proposedLeaseId = Guid.NewGuid().ToString();
        return await blockBlob.ChangeLeaseAsync(
            proposedLeaseId,
            AccessCondition.GenerateLeaseCondition(leaseId));
    }
    ```

</details>

Call the following methods in the main method and implement the **ReleaseBlobLeaseAsync** method:

```csharp
ReleaseBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    leaseId)
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease released on {blobName}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **ReleaseBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task ReleaseBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        string leaseId)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        await blockBlob.ReleaseLeaseAsync(AccessCondition.GenerateLeaseCondition(leaseId));
    }
    ```

</details>

#### Task 6: Break the lease

Call the following methods in the main method and implement the **BreakBlobLeaseAsync** method:

```csharp
leaseId = AcquireBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    new TimeSpan(0, 0, leaseDurationinSeconds))
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease acquired on {blobName}: {leaseId}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();

TimeSpan breakTime = BreakBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    new TimeSpan(0, 0, 5))
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease will be broken on {blobName} in {breakTime.ToString()}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();

try
{
    leaseId = AcquireBlobLeaseAsync(
        connectionstring,
        container,
        blobName,
        new TimeSpan(0, 0, leaseDurationinSeconds))
    .GetAwaiter()
    .GetResult();
    Console.WriteLine($"Lease acquired on {blobName}: {leaseId}");

    DisplayBlobLeaseAsync(
        connectionstring,
        container,
        blobName)
    .GetAwaiter()
    .GetResult();
}
catch
{
    Console.WriteLine($"Failed to acquire a lease on {blobName}");

    DisplayBlobLeaseAsync(
        connectionstring,
        container,
        blobName)
    .GetAwaiter()
    .GetResult();
}

Wait((int)breakTime.TotalSeconds);

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();

leaseId = AcquireBlobLeaseAsync(
    connectionstring,
    container,
    blobName,
    new TimeSpan(0, 0, leaseDurationinSeconds))
.GetAwaiter()
.GetResult();
Console.WriteLine($"Lease acquired on {blobName}: {leaseId}");

DisplayBlobLeaseAsync(
    connectionstring,
    container,
    blobName)
.GetAwaiter()
.GetResult();
```

<details>
<summary>Click here to display answers</summary>

1. Implement the **BreakBlobLeaseAsync** method as follow:

    ```csharp
    private static async Task<TimeSpan> BreakBlobLeaseAsync(
        string storageAccountConnectionString,
        string blobContainer,
        string blobName,
        TimeSpan breakReleaseTime)
    {
        CloudStorageAccount storageAccount = CloudStorageAccount.Parse(storageAccountConnectionString);
        CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
        CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);
        CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

        return await blockBlob.BreakLeaseAsync(breakReleaseTime);
    }
    ```

</details>

#### Task 7: Start debugging to test the methods

## Lab 1: Implement blob leasing from HTTP requests

:stopwatch: 5 minutes

#### Task 1: Acquire a new lease

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

#### Task 2: Renew an existing lease

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Change the ID of an existing lease

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

#### Task 4: Release the blob

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 5: Break the lease

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>