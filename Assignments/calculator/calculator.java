import java.util.Scanner;

class calculator{
    public static int addNumbers(int number1, int number2){
        return number1 + number2;
    }
    public static int subtractNumber(int number1, int number2){
        return number1 - number2;
    }
    public static int multiplyNumbers(int number1, int number2){
        return number1 * number2;
    }
    public static int divideNumbers(int number1, int number2){
        return number1 / number2;
    }
    public static void main(String[] args) {
        int num1, num2, op, opSelection;
        Scanner userInputScanner = new Scanner(System.in);
        System.out.println("Simple Calculator");
        System.out.println("1-ADD \n 2-SUB \n 3-MULT \n 4-DIV");
        opSelection = userInputScanner.nextInt();
        switch(opSelection){
            case 1:
                num1 = userInputScanner.nextInt();
                num2 = userInputScanner.nextInt();
                op = addNumbers(num1, num2);
                System.out.println(op);
                break;
            case 2:
                num1 = userInputScanner.nextInt();
                num2 = userInputScanner.nextInt();
                op = subtractNumber(num1, num2);
                System.out.println(op);
                break;
            case 3:
                num1 = userInputScanner.nextInt();
                num2 = userInputScanner.nextInt();
                op = multiplyNumbers(num1, num2);
                System.out.println(op);
                break;
            case 4:
                num1 = userInputScanner.nextInt();
                num2 = userInputScanner.nextInt();
                op = divideNumbers(num1, num2);
                System.out.println(op);
                break;
        }
        userInputScanner.close();
    }
}