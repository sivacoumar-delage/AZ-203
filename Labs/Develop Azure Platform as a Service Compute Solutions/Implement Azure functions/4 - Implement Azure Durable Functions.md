# Azure Durable Functions

The following labs should be done in Visual Studio 2017.

## Lab 1: Simplify the Chaining pattern

#### Task 1: Create a simple orchestration of three functions calls

<details>
<summary>Click here to display answers</summary>

1. Open **Visual Studio 2017**

1. In **Visual Studio**, select **New** > **Project** from the **File** menu

1. In the **New Project** dialog, expand **Installed**, expand **Visual C#** > **Cloud**, select **Azure Functions**

1. Next to  **Name** type *az203AzureDurableFunctions*

1. Click **OK**

1. In the **New Project - az203AzureDurableFunctions** dialog, select **Azure Function v2 (.NET Core)**

1. Select the **Empty** template

1. Under **Storage Account**, selct **Storage Emulator**

1. Click **OK**

1. Right-click the project and select **Add** > **New Azure Function**

1. Select **Azure Function**, next to **Name** type *RunOrchestrator*, click **Add**

1. Select the **Durable Function Orchestration** template, click **OK**

1. Rename the **RunOrchestrator.cs** file by **ChainingPattern.cs**

1. In the refactoring dialog, click **Yes** in order to rename the class as well

1. The template comes with three functions : an Http triggered function, and an Activity triggered function who is called three times in the RunOrchestrator function

1. Click in the menu **Debug**, and select **Start Debugging**

1. Copy the **RunOrchestrator_HttpStart** URL

1. Open **Postman**, and trigger the Http function by pasting the **URL**, selecting the **POST** method and clicking **Send**

1. In the console, the log displays the execution of the **RunOrchestrator_Hello**

    ...
    Saying hello to Tokyo.
    ...
    Saying hello to Seattle.
    ...
    Saying hello to London.
    ...

1. Click in the menu **Debug**, and select **Stop Debugging**

</details>

#### Task 2: Create a sub-orchestration of two functions and replace the second call in the previous orchestration with the sub-orchestration

> **Note:** [Click here to consult the documentation regarding **Sub-orchestrations in Durable Functions**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-sub-orchestrations).

<details>
<summary>Click here to display answers</summary>

1. Copy the method **RunOrchestrator** and rename the duplicate by **RunSubOrchestration**

1. In the content of the **RunSubOrchestration** method, call the **RunOrchestrator_Hello** twice, one with *Paris* input, and the second with *Seattle* (remove the third call)

    You should have the following code:

    ```csharp
    [FunctionName("RunSubOrchestration")]
    public static async Task<List<string>> RunSubOrchestration(
        [OrchestrationTrigger] DurableOrchestrationContext context)
    {
        var outputs = new List<string>();

        outputs.Add(await context.CallActivityAsync<string>("RunOrchestrator_Hello", "Paris"));
        outputs.Add(await context.CallActivityAsync<string>("RunOrchestrator_Hello", "Seattle"));

        return outputs;
    }
    ```

1. In the **RunOrchestrator** method, comment the second call to the **RunOrchestrator_Hello** function and add the following instruction:

    ```csharp
    await context.CallSubOrchestratorAsync("RunSubOrchestration", null);
    ```

1. Place a breakpoint in the last instruction of the **RunOrchestrator** method

1. Start debugging and trigger the orchestration with Postman

1. Check the **Logs** in the console application

       ...
    Saying hello to Tokyo.
    ...
    Saying hello to Paris.
    ...
    Saying hello to Seattle.
    ...
    Saying hello to London.
    ...

1. When the breakpoint hit, check the value of the *outputs* list

    Paris and Seattle should be missing

1. Stop Debugging

1. In the **RunOrchestrator** method, replace the call to the sub orchestration by the following instruction:

    ```csharp
    List<string> subOrchestrationOutputs = await context.CallSubOrchestratorAsync<List<string>>("RunSubOrchestration", null);
    ```

1. Add the following instruction after the call to the sub orchestration to add the outputs from the sub orchestration to the outputs of the main orchestration

    ```csharp
    outputs.AddRange(subOrchestrationOutputs);
    ```

1. Start debugging and trigger the orchestration with Postman

1. When the breakpoint hit, check the value of the *outputs* list

    All four cities should be in the *outputs* list

1. Stop Debugging

</details>

#### Task 3: Adding two new activity functions Start and End

The function Start should be called in the beginning of the orchestration and log *Start*.
The function End should be called at the end of the orchestration and log *End*.

<details>
<summary>Click here to display answers</summary>

1. Add the following activity functions:

    ```csharp
    [FunctionName("RunOrchestrator_Start")]
    public static void Start([ActivityTrigger] object input, ILogger log)
    {
        log.LogWarning($"Start");
    }

    [FunctionName("RunOrchestrator_End")]
    public static void End([ActivityTrigger] object input, ILogger log)
    {
        log.LogWarning($"End");
    }
    ```

    > **Note:** Activity functions must have an input object with the attribute ActivityTrigger to make them activty functions.

    > **Information:** The LogWarning method is used as the logs will appear in yellow in the console application. Making them more visible for debug purposes.

1. In the **RunOrchestrator** method, add the following call at the beginning of the method:

    ```csharp
    await context.CallActivityAsync("RunOrchestrator_Start", null);
    ```

1. In the **RunOrchestrator** method, add the following call at the end of the method, before the return instruction:

    ```csharp
    await context.CallActivityAsync("RunOrchestrator_End", null);
    ```

</details>

#### Task 4: Logging with replays

<details>
<summary>Click here to display answers</summary>

1. Add the following activity function:

    ```csharp
    [FunctionName("LogWarning")]
    public static string LogWarning([ActivityTrigger] string input, ILogger log)
    {
        log.LogWarning(input);
        return input;
    }
    ```

1. Replace the content of the **RunSubOrchestration** method with the following code:

    ```csharp
    var outputs = new List<string>();

    Random random = new Random();
    int randomNumber = random.Next(0, 100);

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", randomNumber.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", randomNumber.ToString()));

    Guid uniqueIdentifier = Guid.NewGuid();

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", uniqueIdentifier.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", uniqueIdentifier.ToString()));

    DateTime currentDate = DateTime.Now;

    outputs.Add(await context.CallActivityAsync<string>("LogWarning", currentDate.ToString()));
    outputs.Add(await context.CallActivityAsync<string>("LogWarning", currentDate.ToString()));

    return outputs;
    ```

1. Add the using statement to resolve the errors

    ```csharp
    using System;
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The **Logs** display two different random numbers, Guids and dates.

    > **Warning:** The replay behavior creates constraints on the type of code that can be written in an orchestrator function:
    >
    > Orchestrator code must be deterministic. It will be replayed multiple times and must produce the same result each time. For example, no direct calls to get the current date/time, get random numbers, generate random GUIDs, or call into remote endpoints.
    >
    > If orchestrator code needs to get the current date/time, it should use the CurrentUtcDateTime (.NET) or currentUtcDateTime (JavaScript) API, which is safe for replay.
    >
    > If orchestrator code needs to generate a random GUID, it should use the NewGuid (.NET) API, which is safe for replay, or delegate GUID generation to an activity function (JavaScript).
    >
    >
    > [Click here to cinsult the documentation regarding the **Orchestrator code constraints**](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-checkpointing-and-replay#orchestrator-code-constraints).

1. Stop debugging

1. Add a new class called MinMaxRange with the following properties:

    ```csharp
    public class MinMaxRange
    {
        public int Min;
        public int Max;
    }
    ```

1. Add a new activty function in order to return a safe random number

    ```csharp
    [FunctionName("GenerateRandomNumber")]
    public static int GenerateRandomNumber([ActivityTrigger] MinMaxRange input, ILogger log)
    {
        Random random = new Random();
        int randomNumber = random.Next(input.Min, input.Max);

        return randomNumber;
    }
    ```

1. Add a new activty function in order to return a safe new Guid

    ```csharp
    [FunctionName("GenerateNewGuid")]
    public static Guid GenerateNewGuid([ActivityTrigger] object input, ILogger log)
    {
        return Guid.NewGuid();
    }
    ```

1. Use the new activity functions to replace the non deterministic methods in the **RunSubOrchestration** method:

    ```csharp
    int randomNumber = await context.CallActivityAsync<int>("GenerateRandomNumber", new MinMaxRange { Min = 0, Max = 100 });
    ```

    ```csharp
    Guid uniqueIdentifier = await context.CallActivityAsync<Guid>("GenerateNewGuid", null);
    ```

1. Replace DateTime.Now by context.CurrentUtcDateTime

    ```csharp
    DateTime currentDate = context.CurrentUtcDateTime;
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The **Logs** should display the same random numbers, Guids and dates.

1. Stop debugging

</details>

#### Task 5: Handling errors

> **Note:** [Click here to consult the document regarding Errors handling in activity functions](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-error-handling#errors-in-activity-functions).

<details>
<summary>Click here to display answers</summary>

1. Create a new activity function called *RaiseError* which raises an Exception

    ```csharp
    [FunctionName("RaiseError")]
    public static void RaiseError([ActivityTrigger] object input, ILogger log)
    {
        throw new Exception("An error occured for testing purposes.");
    }
    ```

1. Call the *RaiseError* activity function in the main orchestration function before calling the sub orchestration function

    ```csharp
    await context.CallActivityAsync("RaiseError", null);
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

1. Stop debugging when the exception is raised

1. Wrap the activity functions calls with a try/finally block (after the Start function and before the End function).

1. Move the End function in the finally block

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

1. When the exception is raised, check that the End function is called

1. Stop debugging

</details>

#### Task 6: Handling retries

<details>
<summary>Click here to display answers</summary>

> **Note:** [Click here to consult the document regarding Automatic retry on failure](https://docs.microsoft.com/en-us/azure/azure-functions/durable/durable-functions-error-handling#automatic-retry-on-failure).

1. Replace the call to the *RaiseError* activity function by the following code:

    ```csharp
    var retryOptions = new RetryOptions(
        firstRetryInterval: TimeSpan.FromSeconds(10),
        maxNumberOfAttempts: 3);
    await context.CallActivityWithRetryAsync("RaiseError", retryOptions, null);
    ```

1. Start debugging, trigger the orchestration with **Postman** and check the **Logs**

    The error should be raised three times.

1. Stop debugging

1. Comment the call to the *RaiseError* activity function

</details>

#### Task 7: Handling cancellation

<details>
<summary>Click here to display answers</summary>

1. Start debugging, trigger the orchestration with **Postman**

1. In **Postman**, under **Http Response Body**, click the link next to **terminatePostUri**

1. In the new tab, select **POST** and click **Send**

1. After a 202 response, close the tab

1. In **Postman**, under **Http Response Body**, click the link next to **statusQueryGetUri**

1. In the new tab, click **Send**

1. Check the **Http Response Body**

    It should display 
    
    ```json
    "runtimeStatus": "Terminated",
    ```

1. Check the **Logs**

</details>

## Lab 2: Implement a Fan-in / fan-out pattern

#### Task 1: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 3: Handling human interaction in an orchestration

#### Task 1: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 4: Coordinate the state of long-running operations with the Async HTTP APIs pattern

#### Task 1: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 5: Replace a timer trigger with the Monitoring pattern

#### Task 1: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Task_Name

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

## Lab 6: Dealing with breaking changes when deploying a new version

#### Task 1: Stop all in-flight instances by clearing the contents of the internal control-queue and workitem-queue queues

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>

#### Task 2: Side-by-side deployments with deployment slots and the Task Hub

<details>
<summary>Click here to display answers</summary>

1. Step 1

1. Step 2

</details>