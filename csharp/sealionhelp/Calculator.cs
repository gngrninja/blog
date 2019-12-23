using System;

namespace Calculator
{
    class Calculator
    {
        public static void PrintOptions()
        {
            System.Console.WriteLine("What would you like to do?");
            System.Console.WriteLine("+ (add)");
            System.Console.WriteLine("- (subtract)");
            System.Console.WriteLine("* (multiply)");
            System.Console.WriteLine("/ (divide)");
            System.Console.WriteLine("(+,-,*,/, or 'q' to quit)");            
        } 

        public static void Start()
        {                   
            do {         
                //print options for the user
                PrintOptions();

                //read the user's input, and store in response                
                var response = Console.ReadLine();

                switch (response)
                {
                    case "q":
                    {
                        //exit if q
                        System.Console.WriteLine("Exiting!");
                        //return will exit the loop, and thus the app. 
                        return;
                    }
                    case "+":
                    {
                        //add!
                        //break simply exists the switch statement
                        DoAddition();
                        break;
                    }
                    case "-":
                    {
                        //subtract!
                        DoSubtraction();
                        break;                        
                    }
                    default:
                    {
                        //we use continue here so the loop starts again at the top, which is what we want for an invalid option
                        System.Console.WriteLine($"[{response}] is not a valid option!");
                        System.Console.WriteLine();
                        continue;
                    }
                }                                                
            } while (true); 
        }

        private static void DoSubtraction()
        {
            int first, second;
            AskForNumbers(out first, out second);
            
            var result = first - second;
            
            Console.WriteLine($"[{first}] minus [{second}] equals [{result}]");
            System.Console.WriteLine();            
        }

        private static void DoAddition()
        {
            int first, second;
            AskForNumbers(out first, out second);

            var result = first + second;

            Console.WriteLine($"[{first}] plus [{second}] equals [{result}]");            
            System.Console.WriteLine();
        }

        private static void AskForNumbers(out int first, out int second)
        {
            Console.WriteLine("Enter first number: ");
            first = int.Parse(Console.ReadLine());

            System.Console.WriteLine();

            Console.WriteLine("Enter second number: ");
            second = int.Parse(Console.ReadLine());

            System.Console.WriteLine();
        }
    }
}
