# Execute an Azure Function with triggers

## Lab 1: …by using data operations

#### Task 1: Create a Function Apps named az203functions-Triggers-XXXXX

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **App Services**

1. Click on the button **Add**

1. In the **Marketplace** blade, click **Function App**

1. Click **Create**

1. In the **Function App** blade, under **App name**, replace XXXXX by a unique name and type *az203functions-Triggers-XXXXX*

1. Under **Subscription**, select your active and valid subscription

1. Under **Resource Group**, select **Use existing**, then select the *az203-rg* resource group

1. Under **OS**, leave the default value to **Windows**

1. Under **Hosting Plan**, leave the default value to **Consumption Plan**

    > **Note:** Hosting plan that defines how resources are allocated to your function app. In the default **Consumption Plan**, resources are added dynamically as required by your functions. In this serverless hosting, you only pay for the time your functions run. When you run in an **App Service Plan**, you must manage the scaling of your function app.

1. Under **Location**, select the nearest location

1. Under **Runtime Stack**, select **.NET**

   > **Note:** Choose a runtime that supports your favorite function programming language. Choose .NET for C# and F# functions.

1. Under **Storage**, select **Use existing**, then select the *az203storageaccountXXXXX* you created in a previous module

1. Under **Application Insights**, select **Disabled**

1. Click **Create**

</details>

#### Task 2: Create and test a Queue storage in Azure

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in a previous lab

1. In the **Storage account** blade, click **Queues** in the menu

1. In the **Queues** blade, click on the button **Queue** in order to add a new queue

1. In the **Add queue** dialog, under **Queue name**, type *az203-queue-storage*

1. In the **Queues** blade, click *az203-queue-storage*

1. In the *az203-queue-storage* blade, click on the button **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *Alpha*

1. Click **OK**

1. Repeat the last two steps to add the messages *Beta* and *Omega*

1. In the *az203-queue-storage* blade, check that the messages has been added to the queue

1. Select the message *Beta*

1. Click on the button **Dequeue message**

1. In the **Dequeue first message** dialog, click **Yes**

    The message *Alpha* will be removed from the queue. 
    
    > **Note:** A queue is first in, first-out.

1. Click on the button **Clear queue**

1. In the **Dequeue all messages** dialog, click **Yes**

    All the messages should be removed from the queue.

</details>

#### Task 3: Create a function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Triggers-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Azure Queue Storage trigger**

1. In the **Extensions not Installed** dialog, click **Install**

1. In the **Extensions Installation Succeeded** dialog, click **Continue**

1. In the **New Function** dialog, under **Name**, type *QueueTriggeredFunction*

1. Under **Queue name**, type *az203-queue-storage*

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** blade, select *az203storageaccountXXXXX*

1. Click **Create**

</details>

#### Task 4: Test the function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a new tab and navigate to [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts** and select *az203storageaccountXXXXX*

1. Click **Queues** and select *az203-queue-storage*

1. Go back in the tab with the *QueueTriggeredFunction* blade, click **Run**

    The **Request body** displays the message sent to the queue. The **Logs** displays the information with the message content.

1. Update the **Request body** with the message *testfromFunctionApp* and click **Run**

    The **Logs** should display "C# Queue trigger function processed: testfromFunctionApp"

1. Go to the other tab with the **Queue Storage** blade, and click **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *testFromQueue*, and click **OK**

1. Click **Refresh**

1. Go back to the tab with the *QueueTriggeredFunction* blade, check the **Logs**

    The **Logs** should display "C# Queue trigger function processed: testFromQueue"

</details>

#### Task 5: Create and test a Queue storage locally in Azure Storage Explorer

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Queues** and select **Create Queue**

1. Type *az203-queue-storage*

1. In the *az203-queue-storage* tab, click on the button **Add Message**

1. In the **Microsoft Azure Storage Explorer - Add Message** dialog, under **Message text**, type *Alpha*

1. Click **OK**

1. Repeat the last two steps to add the messages *Beta* and *Omega*

1. In the *az203-queue-storage* tab, check that the messages has been added to the queue

1. Select the message *Beta*

1. Click on the button **Dequeue Message**

1. In the pop-up dialog, click **Yes**

    The message *Alpha* will be removed from the queue. 
    
    > **Note:** A queue is first in, first-out.

1. Click on the button **Clear Queue**

1. In the pop-up dialog, click **Yes**

    All the messages should be removed from the queue.

1. Click on **Emulator - Default Ports (Key)**

1. In the bottom left, copy and save the **Primary Connection String** value

</details>

#### Task 6: Create a function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Start **Visual Studio 2017** and open the *az203functions* solution

1. In the **Solution Explorer**, right-click the *az203functions* project and select **Add** > **New Azure Function...**

1. In the **Add New Item - az203functions** dialog, under **Name**, type *QueueTriggeredFunction*

1. Click **Add**

1. In the **New Azure Function - QueueTriggeredFunction** dialog, select **Queue trigger**

1. Under **Connection string setting**, type *az203storageaccountXXXXX_STORAGE*

1. Under **Queue name**, type *az203-queue-storage*

1. Click **OK**

    A new file called *QueueTriggeredFunction.cs* should be created. an error indicates that the **QueueTrigger** attribute could not be found.

1. In the **Solution Explorer**, right-click the *az203functions* project and select**Manage NuGet Packages...**

1. In the **NuGet** tab, click **Browse**

1. Search *Microsoft.Azure.WebJobs.Extensions.Storage*, and select **Microsoft.Azure.WebJobs.Extensions.Storage**

1. Click **Install**, and in the **License Acceptance** dialog, click **I Accept**

1. Close the **NuGet** tab
    
    In the *QueueTriggeredFunction.cs* file, the **QueueTrigger** attribute sould be resolved.

1. In the **Solution Explorer**, open the **local.settings.json**

1. In the **View** menu, open **Cloud Explorer**, expand **(Local)** > **Storage Accounts** > **(Development) (Key)**, then select Properties and copy the Primary Connection String value.

1. In the **local.settings.json** file, under **Values** section, add a setting called *az203storageaccountXXXXX_STORAGE* and paste the **Primary Connection String** copied during the previous task

</details>

#### Task 7: Test the function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Click the **Debug** menu, and select **Start Debugging**

    > **Warning!** If an exception is raised, make sure that the time displayed in the console matches the one on your local machine. If not, adjust the time in your computer (usually **(UTC) Coordinated Universal Time**)

1. Go back to **Microsoft Azure Storage Explorer**, select the queue *az203-queue-storage* and add a message with the text *testFromLocal*

    The message should be added to the queue

1. Click the **Refresh** button

    The queue should be empty

1. Go back to the Azure functions console

    *C# Queue trigger function processed: testFromLocal* should be displayed in the **Logs**

1. In **Visual Studio**, click the **Debug** menu, and select **Stop Debugging**

</details>

#### Task 8: Create a Blob storage in Azure

<details>
<summary>Click here to display answers</summary>

1. Create three text files named *Alpha*, *Beta*, and *Omega* on your computer

1. Open each file, and type the name of the file in the content

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in a previous lab

1. In the **Storage account** blade, click **Blobs** in the menu

1. In the **Blobs** blade, click on the button **Container** in order to add a new blob storage

1. In the **New container** dialog, under **Name**, type *az203-blob-storage*

1. Under **Public access level**, select **Blob (anonymous read access for blobs only)**

1. Click **OK**

1. In the **Blobs** blade, click *az203-blob-storage*

1. In the *az203-blob-storage* blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. Browse and select the first text file *Alpha*

1. Expand **Advanced**

1. Under **Blob type**, select **Block blob**

    > **Note:** [Click here to consult the documentation to understand Block Blobs, Append Blobs, and Page Blobs](https://docs.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

1. Click **Upload**

1. Repeat the last six steps to upload the files *Beta* and *Omega*

1. In the *az203-blob-storage* blade, check that the files has been uploaded in the storage

1. Select the file *Beta.txt*

1. Copy the **URL** of the file

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The content of the text file should be displayed: *Beta*.

1. Close the tab

1. In **Azure Portal**, go back to the *az203-blob-storage* blade

1. In the *az203-blob-storage* blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. In **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg* and click **Open**

1. Expand **Advanced**

1. Under **Blob type**, select **Block blob**

    > **Note:** [Click here to consult the documentation to understand Block Blobs, Append Blobs, and Page Blobs](https://docs.microsoft.com/en-us/rest/api/storageservices/understanding-block-blobs--append-blobs--and-page-blobs)

1. Click **Upload**

1. In the *az203-blob-storage* blade, check that the picture has been uploaded in the storage

1. Select the file *avanade-logo\[1].svg*

1. Copy the **URL** of the file

1. In the web browser, open a new tab, paste the **URL** and navigate to the blob

    The picture should be displayed.

1. Close the tab

1. Select all files

1. Click **Delete**

1. In the **Delete blob(s)** dialog, click **OK**

</details>

#### Task 9: Create a function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Triggers-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Azure Blob Storage trigger**

1. In the **New Function** dialog, under **Name**, type *BlobTriggeredFunction*

1. Under **Path**, type *az203-blob-storage/{name}*

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** blade, select *az203storageaccountXXXXX*

1. Click **Create**

</details>

#### Task 10: Test the function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a new tab and navigate to [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts** and select *az203storageaccountXXXXX*

1. Click **Blobs** and select *az203-blob-storage*

1. Go back in the tab with the *BlobTriggeredFunction* blade, click **Logs**

1. Go to the tab with the **Blob Storage** blade, click on the button **Upload**

1. In the **Upload blob** dialog, under **Files**, click **Select a file**

1. In **File name**, type *https://www.avanade.com/~/media/logo/avanade-logo.svg* and click **Open**

1. Click **Upload**

1. Close the **Upload blob** dialog

1. Go back to the tab with the *BlobTriggeredFunction* blade, check the **Logs**

    The **Logs** should display "C# Blob trigger function Processed blob Name:avanade-logo[1].svg"

1. Go to the tab with the **Blob Storage** blade, click on the button **Refresh**

    The picture should remain in the storage.

</details>

#### Task 11: Create a Blob storage locally in Azure Storage Explorer

<details>
<summary>Click here to display answers</summary>

1. Start **Microsoft Azure Storage Explorer**

1. Expand **Local & Attached** > **Storage Accounts** > **Emulator - Default Ports (Key)**

1. Right-click **Blob Containers** and select **Create Blob Container**

1. Type *az203-blob-storage*

1. In the *az203-blob-storage* tab, click on the button **Upload**, then select **Upload Files...**

1. In the **Microsoft Azure Storage Explorer - Upload Files** dialog, under **Files**, click **No files selected**

1. Browse and select the three files *Alpha*, *Beta* and *Omega*

1. Click **Upload**

1. In the *az203-blob-storage* tab, check that the files has been uploaded in the storage

1. Select the file *Beta*

1. Click on the button **Open**

    The file will be opened.

1. Close the file

1. Select all files in the **Blob storage**

1. Click on the button **More** > **Delete**

1. In the pop-up dialog, click **Delete**

1. In the notification on the top, click **Yes** in order to refresh the storage view

    All the files should be deleted from the storage.

</details>

#### Task 12: Create a function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Go to **Visual Studio 2017** instance with the *az203functions* solution

1. In the **Solution Explorer**, right-click the *az203functions* project and select **Add** > **New Azure Function...**

1. In the **Add New Item - az203functions** dialog, under **Name**, type *BlobTriggeredFunction*

1. Click **Add**

1. In the **New Azure Function - BlobTriggeredFunction** dialog, select **Blob trigger**

1. Under **Connection string setting**, type *az203storageaccountXXXXX_STORAGE*

1. Under **Path**, type *az203-blob-storage*

1. Click **OK**

</details>

#### Task 13: Test the function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Click the **Debug** menu, and select **Start Debugging**

1. Go back to **Microsoft Azure Storage Explorer**, select the **Blob Container** *az203-blob-storage* and upload the picture located in *https://www.avanade.com/~/media/logo/avanade-logo.svg*

    The file should be added to the storage.

1. Go back to the Azure functions console

    *C# Blob trigger function Processed blob<br />Name:avanade-logo[1].svg* should be displayed in the **Logs**

1. In **Visual Studio**, click the **Debug** menu, and select **Stop Debugging**

</details>

## Lab 2: …by timers

#### Task 1: Create a function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, go to the *az203functions-Triggers-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Timer trigger**

1. In the **New Function** dialog, under **Name**, type *LogEveryTenSeconds*

1. Under **Schedule**, type *\*/10 \* \* \* \* \**

1. Click **Create**

</details>

#### Task 2: Test the function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In the *LogEveryTenSeconds* function blade, click **Logs**

1. Check that the function is triggered every ten seconds

</details>

#### Task 3: Delete the function with Timer trigger from Azure Portal

> **Note:** In consumption plan, the cost is based on execution time and total executions. The schedule of a Timer triggered functions should be planned accordingly. [Click here to consult the Azure Functions pricing](https://azure.microsoft.com/en-us/pricing/details/functions/).

<details>
<summary>Click here to display answers</summary>

1. Under *LogEveryTenSeconds* menu, click **Manage**

1. Click **Delete function**

1. In the confirmation dialog, click **OK**

</details>

#### Task 4: Create a function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Go to **Visual Studio 2017** instance with the *az203functions* solution

1. In the **Solution Explorer**, right-click the *az203functions* project and select **Add** > **New Azure Function...**

1. In the **Add New Item - az203functions** dialog, under **Name**, type *LogEveryTenSeconds*

1. Click **Add**

1. In the **New Azure Function - LogEveryTenSeconds** dialog, select **Timer trigger**

1. Under **Schedule**, type *\*/10 \* \* \* \* \**

1. Click **OK**

</details>

#### Task 5: Test the function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Click the **Debug** menu, and select **Start Debugging**

1. In the **Azure Functions console**, check that a new log is displayed every ten seconds

1. In **Visual Studio**, click the **Debug** menu, and select **Stop Debugging**

</details>

#### Task 6: Delete the function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. In **Visual Studio**, in the **Solution Explorer**, right-click the file *LogEveryTenSeconds.cs* and select **Delete**

1. In the confirmation dialog, click **OK**

</details>

## Lab 3: …by webhooks

#### Task 1: Create a function with Generic webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **Azure Portal**, go to the *az203functions-Triggers-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **HTTP trigger**

1. In the **New Function** dialog, under **Name**, type *GitHubTriggeredFunction*

1. Under **Authorization level**, select **Function**

1. Click **Create**

1. In the *GitHubTriggeredFunction* blade, 

1. Replace the content of the run function with the following code:

    log.LogInformation("C# HTTP trigger function processed a request.");<br />
    <br />
    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();<br />
    dynamic data = JsonConvert.DeserializeObject(requestBody);<br />
    string issueName = $"The issue {data?.issue?.title} has been created in GitHub.";<br />
    <br />
    string result = issueName ?? "Hello GitHub!";<br />
    log.LogInformation(result);<br />
    return (ActionResult)new OkObjectResult(result);<br />

1. Click **Save**

1. Click **Get function URL**

1. In the **Get function URL** dialog, click **Copy** and save the **URL**

</details>

#### Task 2: Create and configure a GitHub webhook

<details>
<summary>Click here to display answers</summary>

1. In a web browser, open a new tab and go to [GitHub](https://github.com/)

1. Create an account or sign-in

1. Click **Repositories**

1. Click **New**

1. Under **Repository name**, type *az203webhook*

1. Select **Private**

1. Click **Create repository**

1. In the repository page, click **Settings**

1. In the **Settings** page, click the menu **Webhooks**

1. In the **Webhooks** page, click **Add webhook**

1. Under **Payload URL**, paste the **URL** copied earlier 

1. Under **Content type**, select **application/json**

1. Under **Which events would you like to trigger this webhook?**, select **Send me everything**

1. Click **Add webhook**

1. Check that the last delivery was successful

</details>

#### Task 3: Test the function with GitHub webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. In **GitHub**, right-click the link **Issues** and open a new tab

1. In the **Issues** page, click **New issue**

1. In the **Title** field, type *Alpha*

1. Click **Submit new issue**

1. Click **New issue**

1. In the **Title** field, type *Beta*

1. Click **Submit new issue**

1. Click **New issue**

1. In the **Title** field, type *Omega*

1. Click **Submit new issue**

1. Close the **Issue** tab

1. Refresh the **Webhook page** and check the **Recent Deliveries**

1. In **Azure Portal**, in the function blade, click **Logs** and check that the function is trigerred

    The **Logs** should display:<br />
    \[Information] The issue Alpha has been created in GitHub. <br />
    \[Information] The issue Beta has been created in GitHub. <br />
    \[Information] The issue Omega has been created in GitHub. <br />

</details>

#### Task 4: Clean-up by deleting the az203webhook GitHub repository and the GitHubTriggeredFunction Azure Function

<details>
<summary>Click here to display answers</summary>

1. In **GitHub**, go to the *az203webhook* repository

1. Click **Settings**

1. Click **Delete this repository**

1. In the **Are you absolutely sure?** dialog, type the name of the repository and click **I understand the consequences, delete this repository**

    > **Warning!** Be careful and check that you have selcted the proper repository as this operation can not be reversed.

1. In **Azure Portal**, under *GitHubTriggeredFunction* menu, click **Manage**

1. Click **Delete function**

1. In the confirmation dialog, click **OK**

</details>