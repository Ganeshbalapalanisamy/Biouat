public class YourController {
  public String recordErrorMessage { get; set; }

  public YourController() {
    try {
      // Perform your logic with the record submission or validation
    } catch (Exception e) {
      recordErrorMessage = JSON.serialize(e.getMessage());
    }
  }
}