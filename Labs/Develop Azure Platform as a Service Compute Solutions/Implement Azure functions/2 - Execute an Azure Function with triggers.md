# Execute an Azure Function with triggers

## Lab 1: …by using data operations

#### Task 1: Create two Function Apps (one for functions created from Azure Portal, one for functions created and published from Visual Studio)

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **App Services**

1. Click on the button **Add**

1. In the **Marketplace** blade, click **Function App**

1. Click **Create**

1. In the **Function App** blade, under **App name**, replace XXXXX by a unique name and type *az203functions-Portal-XXXXX*

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

1. Repeats the same steps, but create a **Function App** called *az203functions-VisualStudio-XXXXX*

1. Go to the *az203functions-VisualStudio-XXXXX* **Function App** 

1. Click on the button **Get publish profile** and download the **.PublishSettings** file

</details>

#### Task 2: Create and test a Queue storage

<details>
<summary>Click here to display answers</summary>

1. In [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts**

1. Click *az203storageaccountXXXXX* created in a previous lab

1. In the **Storage account** blade, click **Queues** in the menu

1. In the **Queues** blade, click on the button **Queue** in order to add a new queue

1. In the **Add queue** dialog, under **Queue name**, type *profile-picture-url-queue*

1. In the **Queues** blade, click *profile-picture-url-queue*

1. In the *profile-picture-url-queue* blade, click on the button **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *Alpha*

1. Click **OK**

1. Repeat the last two steps to add the messages *Beta* and *Omega*

1. In the *profile-picture-url-queue* blade, check that the messages has been added to the queue

1. Select the message *Beta*

1. Click on the button **Dequeue message**

1. In the **Dequeue first message** dialog, click **Yes**

    The message *Alpha* will be removed from the queue. 
    
    > **Note:** A queue is first in, first-out.

1. Click on the button **Clear queue**

1. In the **Dequeue all  messages** dialog, click **Yes**

    All the messages should be removed from the queue.

</details>

#### Task 3: Create a function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Go to the *az203functions-Portal-XXXXX* **Function App** 

1. Click **Functions**

1. Click **New function**

1. Select **Azure Queue Storage trigger**

1. In the **Extensions not Installed** dialog, click **Install**

1. In the **Extensions Installation Succeeded** dialog, click **Continue**

1. In the **New Function** dialog, under **Name**, type *DownloadPictureFromUrl*

1. Click **Create**

1. Under **Queue name**, type *profile-picture-url-queue*

1. Under **Storage account connection**, click **new**

1. In the **Storage Account** blade, select *az203storageaccountXXXXX*

1. Click **Create**

</details>

#### Task 4: Test the function with Queue storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Open a new tab and navigate to [**Azure Portal**](https://portal.azure.com), in the **Favorites** menu, click **Storage accounts** and select *az203storageaccountXXXXX*

1. Click **Queues** and select *profile-picture-url-queue*

1. Go back in the tab, in the *DownloadPictureFromUrl* blade, click **Run**

    The **Request body** displays the message sent to the queue. The **Logs** displays the information with the message content.

1. Update the **Request body** with the message *testfromFunctionApp* and click **Run**

    The **Logs** should display "C# Queue trigger function processed: testfromFunctionApp"

1. Go to the other tab, and click **Add message**

1. In the **Add message to queue** dialog, under **Message text**, type *testFromQueue*, and click **OK**

1. Click **Refresh**

1. Go back to the tab, in the *DownloadPictureFromUrl* blade, check the **Logs**

    The **Logs** should display "C# Queue trigger function processed: testFromQueue"

</details>

#### Task 5: Create a function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 6: Test the function with Queue storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

#### Task 7: Create a Blob storage

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 8: Create a function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

#### Task 9: Test the function with Blob storage trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 10: Create a function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1  

1. Step 2

</details>

#### Task 11: Test the function with Blob storage trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 2: …by timers

#### Task 1: Create a function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Test the function with Timer trigger from Visual Studio

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Create a function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 4: Test the function with Timer trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 3: …by webhooks

#### Task 1: Create and configure a GitHub webhook

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Create a function with GitHub webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 3: Test the function with GitHub webhook trigger from Azure Portal

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>