#create chatbot
chatbot <- function() {
  print("This is an official chatbot from ABC Dental Clinic.")
  print("Please answer the following questions in order to make an appointment.")
  print("If you want to leave the chat, please type 'exit'")
  
  while(TRUE){
    name <- readline("What's your name? ")
    if(name == "exit") {
      print("Thank you for using our chatbot. Have a nice day!")
      break
    } else {
      print(paste("Hi", name))
    } 
    phone <- readline("What's your phone number? ")
    if(phone == "exit") {
      print("Thank you for using our chatbot. Have a nice day!")
      break
    } else {
      print(paste("Your phone number is", phone))
    }
    date <- readline("When would you like to make an appointment? (Answer format YYYY-MM-DD): ")
    if(date == "exit") {
      print("Thank you for using our chatbot. Have a nice day!")
      break
    } else {
      print(paste("Request appointment on", date))
    }
    time <- readline("What time you would like to make an appointment? ")
    if(time == "exit") {
      print("Thank you for using our chatbot. Have a nice day!")
      break
    } else {
      print(paste("Request appointment time at", time))
    }
    confirm <- readline(paste("My name is", name, ", Phone number is", phone, ". Request appointment on", date, "at", time, ". | Type 'Y' to Confirm or Type 'N' to Reject: "))
    if(confirm == "exit") {
      print("Thank you for using our chatbot. Have a nice day!")
      break
    } else if (confirm == "Y") {
      print("Thank you for making an appointment, our team will send confirmation to you via sms shortly.")
      print(paste("Or if there is any problem, our team will call you at", phone, "shortly."))
      break
    } else {
      print("Please re-book the appointment.")
    }
  }
}

chatbot()
