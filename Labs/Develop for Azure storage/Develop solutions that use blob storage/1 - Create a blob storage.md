# Create a blob storage

## Lab 1: Create a blob storage in Azure

:stopwatch: {duration} minutes

#### Task 1: Create a storage account called az203storageaccountXXXXX in Azure

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Create a resource**

1. In the **Azure Marketplace**, select **Storage**, then select **Storage account**

1. Next to **Subscription**, select a valid and active subscription

1. Next to **Resource group**, click **Create new**

1. In the popup, under **Name**, type *az203-rg*, then click **OK**

1. Next to **Storage account name**, type *az203storageaccountXXXXX* (replace XXXXX by a unique name)

1. Next to **Location**, select the location nearest to your location

1. Next to **Performance**, check **Standard**

1. Next to **Account kind**, select **StorageV2 (general purpose v2)**

1. Next to **Replication**, select **Read-access-geo-redundant storage (RA-GRS)**

1. Next to **Access tier (default)**, select **Hot**

1. Click **Review + create**

1. After completion of validation, click **Create**s

</details>


#### Task 2: Create a blob storage called az203-blob-storage in the storage account az203storageaccountXXXXX

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in the previous task

1. In the **Storage account** blade, click **Blobs** in the menu

1. In the **Blobs** blade, click on the button **Container** in order to add a new blob storage

1. In the **New container** dialog, under **Name**, type *az203-blob-storage*

1. Under **Public access level**, select **Blob (anonymous read access for blobs only)**

1. Click **OK**

</details>

#### Task 3: Upload an image to the blob storage from Azure Portal

Image URL: *https://www.avanade.com/~/media/logo/avanade-logo.svg*

<details>
<summary>Click here to display answers</summary>

1. In the **Blobs** blade, click *az203-blob-storage*

1. In the *az203-blob-storage* blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. In **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg* and click **Open**

1. Expand **Advanced**

1. Under **Blob type**, select **Block blob**

    > **Note:** [Click here to consult the documentation to understand Block Blobs, Append Blobs, and Page Blobs](https://docs.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

1. Click **Upload**

</details>

#### Task 4: Open a blob stored in blob storage from a web browser

<details>
<summary>Click here to display answers</summary>

1. In the *az203-blob-storage* blade, check that the picture has been uploaded in the storage

1. Select the file *avanade-logo\[1].svg*

1. Copy the **URL** of the file

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The picture should be displayed.

1. Close the tab

</details>

#### Task 5: Delete a blob from blob storage

<details>
<summary>Click here to display answers</summary>

1. In the *az203-blob-storage* blade, select the image

1. Click **Delete**

1. In the **Delete blob(s)** dialog, click **OK**

</details>

## Lab 2: Create a blob storage in local with Microsoft Azure Storage Explorer

:stopwatch: 10 minutes

#### Task 1: Create a blob storage called az203-blob-storage in Azure Storage Emulator

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Emulator**

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Blob Containers** and select **Create Blob Container**

1. Type *az203-blob-storage*

1. Right click the created blob storage

1. Click **Set Public Access Level...**

1. Select **Public read access for container and blobs**

1. Click **Apply**

</details>

#### Task 2: Upload an image to the local blob storage

<details>
<summary>Click here to display answers</summary>

1. In **Microsoft Azure Storage Explorer**, select the **Blob Container** *az203-blob-storage*

1. Click **Upload**, then select **Upload Files...**

1. Under **Files**, click the **Browse** button

1. Next to **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg*

1. Click **Open**

1. Under **Blob type**, select **Block Blob**

1. Click **Upload**

    The file should be added to the storage.

</details>

#### Task 3: Upload an image to the local blob storage

Image URL: *https://www.avanade.com/~/media/logo/avanade-logo.svg*

<details>
<summary>Click here to display answers</summary>

1. In **Microsoft Azure Storage Explorer**, select the image *avanade-logo.svg*

1. Click **Copy URL**

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The picture should be displayed.

1. Close the tab

</details>

#### Task 4: Delete the image from the local blob storage

<details>
<summary>Click here to display answers</summary>

1. In **Microsoft Azure Storage Explorer**, select the image *avanade-logo.svg*

1. Click **More**, then select **Delete**

1. In the **Microsoft Azure Storage Explorer - Delete** popup, click **Delete**

1. Next to the notification **Your view may be out of date. Do you want to refresh?**, click **Yes**

</details>