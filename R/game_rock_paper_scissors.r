#game01 Complete
playgame <- function(){
  print("Welcome to Rock Paper Scissors Game!")
  options <- c("rock", "paper", "scissors")
  score <- 0
  match <- 0

  
##create loop    
  play_again <- TRUE
  while (play_again) {
    print("Choose rock, paper, scissors or quit")
    user_response <- readline("You choose: ")
    com_response <- sample(options, 1)
    if(user_response != "rock" && user_response != "paper" && user_response != "scissors" && user_response != "quit") {
      print("Your input was not recognized, please try again")
      next
    }
    if(user_response == "quit") {
      play_again <- FALSE
      break
    }
      
    print(paste("Computer chose", com_response))
    match <- match + 1
    
##condition tie    
    if (user_response == com_response) {
      print("tie")
    }
##rock    
    else if (user_response == "rock") {
      if(com_response == "scissors") {
        score <- score + 1
        print ("You win")
      } else if (com_response == "paper"){
        print ("You Lost")
      }
    }
##paper
    else if (user_response == "paper") {
      if(com_response == "rock") {
        score <- score + 1
        print ("You win")
      } else if (com_response == "scissors"){
        print ("You Lost")
      }
    }
##scissors
    else if (user_response == "scissors") {
      if(com_response == "paper") {
        score <- score + 1
        print ("You win")
      } else if (com_response == "rock"){
        print ("You Lost")
      }
    }
    
    
  }
  print("Thank you for playing!")
  print(paste("Your total score is", score, "out of", match))
}

playgame()
