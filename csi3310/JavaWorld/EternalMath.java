/********************************************************************

Copyright (c) 1996 Artima Software Company. All Rights Reserved.

PROJECT:	JavaWorld
MODULE:		Under The Hood
FILE:		EternalMath.java

AUTHOR:		Bill Venners, April 1996

DESCRIPTION:

This file contains all the code for the Java virtual machine simulator that
accompanies the Under The Hood article titled, "The Lean, Mean Virtual Machine".
This software was thrown together rather quickly under a threat of deadline,
so some things are not as general as I would like them to be. In future
installments of the column I plan to move this code towards a more general
implementation of the JVM. Each month's applet will only have the
code required to get that month's point across to minimize the
amount of software that must be downloaded with each article.

I have attempted to keep separate the functionality of the
JVM from the UI I use to display its state. As I go along I forsee having a
JVM object which has inside it a heap object, a stack object, a method area
object, etc., along with methods that perform JVM functions, such as loadClass(),
and methods that return information for the UI to display. In this first version
I just have a few variables in the Applet class that implement the few JVM
parts I actually use in this simulation. The UI of each monthly installment will
vary greatly depending upon what concept I am trying to demonstrate, but underneath
will be a functional object which will become, to an ever greater
extent as the months go by, the JVM ported to itself.



*********************************************************************/


import java.awt.*;

class OpCode {

    public final static byte ICONST_0 = 3;
    public final static byte ICONST_1 = 4;
    public final static byte ICONST_2 = 5;
    public final static byte IADD = 0x60;
    public final static byte ILOAD_0 = 0x1a;
    public final static byte ISTORE_0 = 0x3b;
    public final static byte IMUL = 0x68;
    public final static byte IINC = (byte) 0x84;
    public final static byte GOTO = (byte) 0xa7;
}

public class EternalMath extends java.applet.Applet {

    // Vars for the three outer panels that are contained inside the Applet's panel.
    // twoParts contains the stack and the method area. simulationController
    // contains the Step and Reset buttons and the hint label.
    private RegisterPanel registers;
    private TwoParts twoParts;
    private ControlPanel simulationController;

    // Vars that implements the Java stack
    private final int stackBase = 0x33330000;
    private final int stackMemorySectionSize = 8;
    private StackMemorySection stackMemorySection = new StackMemorySection(stackBase, stackMemorySectionSize);
    private StackMemoryView stackMemoryView;

    // Vars that implements the method area of the JVM
    private final int methodAreaBase = 0x44440000;
    private final int methodAreaMemorySectionSize = 12;
    private MemorySection methodAreaMemorySection = new MemorySection(methodAreaBase,
        methodAreaMemorySectionSize);
    private MemoryView methodAreaMemoryView;

    // Vars that implement the Java registers
    private int pcRegister;
    private int optopRegister;
    private int frameRegister;
    private int varsRegister;

    public void init() {

        setLayout(new BorderLayout(5, 5));

        registers = new RegisterPanel();
        twoParts = new TwoParts();
        simulationController = new ControlPanel();

        add("North", registers);
        add("South", simulationController);
        add("Center", twoParts);

        // Get a reference to the UI objects that are actually manipulated by
        // the handlers of the Step and Reset buttons. These aren't available
        // without this explicit get() because these objects are buried several
        // levels down in embedded panels.
        stackMemoryView = twoParts.getStackMemoryViewReference();
        methodAreaMemoryView = twoParts.getMethodAreaMemoryViewReference();

        // Place the bytecodes into the method area (A primitive class loader --
        // good enough for now.)
        int[] theProgram = { 3, 0x3b, 0x84, 0, 1, 0x1a, 5, 0x68, 0x3b, 0xa7,
            0xff, 0xf9 };
        String[] byteCodeMnemonics = { "iconst_0", "istore_0", "iinc",
            "0 (loc var)", "1 (amount)", "iload_0", "iconst_2", "imul",
            "istore_0", "goto", "-7 (byte1)", "-7 (byte0)" };

        for (int i = 0; i < methodAreaMemorySectionSize; ++i) {

            methodAreaMemorySection.setAtAddress(methodAreaBase + i,
                (byte) theProgram[i]);

            methodAreaMemorySection.setLogicalValueAtAddress(methodAreaBase + i,
                byteCodeMnemonics[i]);
        }

        ResetState();
        UpdateStateDisplay();
}

    public boolean action(Event evt, Object arg) {
        if (evt.target instanceof Button) {
            String bname = (String) arg;
            if (bname.equals("Reset")) {

                ResetState();
                UpdateStateDisplay();
            }
            else if (bname.equals("Step")) {

                ExecuteNextInstruction();
                UpdateStateDisplay();
            }
        }
        return true;
    }

    // ExecuteNextInstruction() grabs the instruction pointed to by the program
    // counter, decodes it via the switch statement, and executes it by running the
    // code under the appropriate case statement. The program counter is always
    // set to the next instruction that should be executed, naturally. Only those
    // bytecodes that appear in the short sequence presented in this simulation
    // are interpreted here to save time (your time in downloading and my time
    // in writing.)
    void ExecuteNextInstruction() {

        int a, b, result, i;
        byte operand0, operand1;

        byte nextOpCode = methodAreaMemorySection.getAtAddress(pcRegister);

        switch (nextOpCode) {

        case OpCode.ICONST_0:
            stackMemorySection.setAtAddress(optopRegister, 0);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "operand");
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.ICONST_1:
            stackMemorySection.setAtAddress(optopRegister, 1);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "operand");
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.ICONST_2:
            stackMemorySection.setAtAddress(optopRegister, 2);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "operand");
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.IADD:
            optopRegister -= 4;
            a = stackMemorySection.getAtAddress(optopRegister);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "");
            optopRegister -= 4;
            b = stackMemorySection.getAtAddress(optopRegister);
            result = a + b;
            stackMemorySection.setAtAddress(optopRegister, result);
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.ILOAD_0:
            a = stackMemorySection.getAtAddress(varsRegister);
            stackMemorySection.setAtAddress(optopRegister, a);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "operand");
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.ISTORE_0:
            optopRegister -= 4;
            a = stackMemorySection.getAtAddress(optopRegister);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "");
            stackMemorySection.setAtAddress(varsRegister, a);
            ++pcRegister;
            break;

        case OpCode.IMUL:
            optopRegister -= 4;
            a = stackMemorySection.getAtAddress(optopRegister);
            stackMemorySection.setLogicalValueAtAddress(optopRegister, "");
            optopRegister -= 4;
            b = stackMemorySection.getAtAddress(optopRegister);
            result = a * b;
            stackMemorySection.setAtAddress(optopRegister, result);
            optopRegister += 4;
            ++pcRegister;
            break;

        case OpCode.IINC:
            operand0 = methodAreaMemorySection.getAtAddress(pcRegister + 1);
            operand1 = methodAreaMemorySection.getAtAddress(pcRegister + 2);
            a = stackMemorySection.getAtAddress(varsRegister + (operand0 * 4));
            a += operand1;
            stackMemorySection.setAtAddress(varsRegister + (operand0 * 4), a);
            pcRegister += 3;
            break;

        case OpCode.GOTO:
            operand1 = methodAreaMemorySection.getAtAddress(pcRegister + 1);
            operand0 = methodAreaMemorySection.getAtAddress(pcRegister + 2);

            int offset = (((int) operand1) << 8) | (((int) operand0) & 0x000000ff);

            pcRegister += offset;
            break;
        }
    }

    // Pushing the Reset button will cause ResetState() to be executed, which will
    // reset all the data to its initial values.
    void ResetState() {

        pcRegister = methodAreaBase;
        optopRegister = stackBase + 20;
        frameRegister = stackBase + 4;
        varsRegister = stackBase;

        stackMemorySection.setLogicalValueAtAddress(stackBase, "local vars");
        int i;
        for (i = 0; i < 4; ++i) {
            stackMemorySection.setLogicalValueAtAddress(stackBase + 4 + (i * 4), "exec env");
        }
        for (i = 0; i < 3; ++i) {
            stackMemorySection.setLogicalValueAtAddress(stackBase + 20 + (i * 4), "");
        }
        for (i = 0; i < 7; ++i) {
            stackMemorySection.setAtAddress(stackBase + (i * 4), 0);
        }
    }

    // UpdateStateDisplay writes the current state of the JVM to the UI.
    void UpdateStateDisplay() {

        registers.setPcRegister(pcRegister);
        registers.setOptopRegister(optopRegister);
        registers.setFrameRegister(frameRegister);
        registers.setVarsRegister(varsRegister);

        stackMemoryView.update(stackMemorySection, stackBase);
        methodAreaMemoryView.update(methodAreaMemorySection, methodAreaBase);

        methodAreaMemoryView.clearPointers();
        methodAreaMemoryView.updatePointer(pcRegister - methodAreaBase, "pc >");

        stackMemoryView.clearPointers();
        stackMemoryView.updatePointer((varsRegister - stackBase) / 4, "vars >");
        stackMemoryView.updatePointer((frameRegister - stackBase) / 4, "frame >");
        stackMemoryView.updatePointer((optopRegister - stackBase) / 4, "optop >");

        byte nextOpCode = methodAreaMemorySection.getAtAddress(pcRegister);

        switch (nextOpCode) {

        case OpCode.ICONST_0:
            simulationController.setExplanationText("iconst_0 will push 0 onto the stack.");
            break;

        case OpCode.ICONST_1:
            simulationController.setExplanationText("iconst_1 will push 1 onto the stack.");
            break;

        case OpCode.ICONST_2:
            simulationController.setExplanationText("iconst_2 will push 2 onto the stack.");
            break;

        case OpCode.ILOAD_0:
            simulationController.setExplanationText("iload_0 will push the integer at local variable 0 onto the stack.");
            break;

        case OpCode.ISTORE_0:
            simulationController.setExplanationText("istore_0 will pop the integer off the top of the stack and store it in local variable 0.");
            break;

        case OpCode.IADD:
            simulationController.setExplanationText("iadd will pop the top two integers off the stack, add them, and push the result back onto the stack.");
            break;

        case OpCode.IMUL:
            simulationController.setExplanationText("imul will pop two integers, multiply them, and push the result.");
            break;

        case OpCode.IINC:
            simulationController.setExplanationText("iinc will increment the specified local variable by the specified amount.");
            break;

        case OpCode.GOTO:
            simulationController.setExplanationText("goto will cause a jump to the specified offset.");
            break;
        }
    }

    // Make pretty border around entire applet panel
    public Insets insets() {
        return new Insets(5, 5, 5, 5);
    }
}

// TwoParts is the panel that contains the Stack and Method Area panels
class TwoParts extends Panel {

    private StackPanel stack;
    private MethodAreaPanel methodArea;

    TwoParts() {

        setLayout(new GridLayout(1,2,5,5));

        stack = new StackPanel();
        methodArea = new MethodAreaPanel();

        stack.setBackground(Color.yellow);
        methodArea.setBackground(Color.green);

        add(stack);
        add(methodArea);
    }

    public StackMemoryView getStackMemoryViewReference() {

        return stack.getMemoryViewReference();
    }

    public MemoryView getMethodAreaMemoryViewReference() {

        return methodArea.getMemoryViewReference();
    }

    // top, left, bottom, right
    // Want a 10 pixel separation between the twoparts and the register panel
    // above and the control panel below.
    public Insets insets() {
        return new Insets(0, 0, 0, 0);
    }
}

class RegisterPanel extends Panel {

    private LabeledRegister pcRegister;
    private LabeledRegister optopRegister;
    private LabeledRegister frameRegister;
    private LabeledRegister varsRegister;

    RegisterPanel() {

        setLayout(new GridLayout(1,5,5,5));

        pcRegister = new LabeledRegister("pc");
        optopRegister = new LabeledRegister("optop");
        frameRegister = new LabeledRegister("frame");
        varsRegister = new LabeledRegister("vars");

        setBackground(Color.cyan);

        add(new Label("Registers", Label.CENTER));
        add(pcRegister);
        add(optopRegister);
        add(frameRegister);
        add(varsRegister);
    }

    public void setPcRegister(int val) {

        pcRegister.setRegister(val);
    }

    public void setOptopRegister(int val) {

        optopRegister.setRegister(val);
    }

    public void setFrameRegister(int val) {

        frameRegister.setRegister(val);
    }

    public void setVarsRegister(int val) {

        varsRegister.setRegister(val);
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(5, 5, 5, 5);
    }
}

class LabeledRegister extends Panel {

    private ColoredLabel registerContents;

    LabeledRegister(String labelText) {

        setLayout(new BorderLayout(5,5));

        registerContents = new ColoredLabel("00000000", Label.CENTER, Color.lightGray);

        add("East", registerContents);
        add("Center", new Label(labelText, Label.RIGHT));
    }

    public void setRegister(int val) {

        HexString hexString = new HexString(val, 8);
        registerContents.setLabelText(hexString.getString());
    }

    public Insets insets() {
        return new Insets(0, 0, 0, 0);
    }
}

// I used this class because I can't seem to set the background color of
// a label.  I only want a label, but I want the backgound to be gray.
class ColoredLabel extends Panel {

    private Label theLabel;

    ColoredLabel(String label, int alignment, Color color) {

        setLayout(new GridLayout(1,1));

        setBackground(color);

        theLabel = new Label(label, alignment);

        add(theLabel);
    }

    public void setLabelText(String s) {

        theLabel.setText(s);
    }

    public Insets insets() {
        return new Insets(0, 0, 0, 0);
    }
}

class StackPanel extends Panel {

    private Label title;
    private StackMemoryViewWithTitles memoryView = new StackMemoryViewWithTitles();

    StackPanel() {

        setLayout(new BorderLayout(5, 5));

        title = new Label("Stack", Label.CENTER);

        add("North", title);
        add("Center", memoryView);
    }

    public StackMemoryView getMemoryViewReference() {

        return memoryView.getMemoryViewReference();
    }

    public Insets insets() {
        return new Insets(5, 5, 5, 5);
    }
}

class MethodAreaPanel extends Panel {

    private Label title;
    private MemoryViewWithTitles memoryView = new MemoryViewWithTitles();

    MethodAreaPanel() {

        setLayout(new BorderLayout(5, 5));

        title = new Label("Method Area", Label.CENTER);

        add("North", title);
        add("Center", memoryView);
    }

    public MemoryView getMemoryViewReference() {

        return memoryView.getMemoryViewReference();
    }

    public Insets insets() {
        return new Insets(5, 5, 5, 5);
    }
}

// MemorySection is just used for the method area in this applet. This implements
// the functionality of the method area and has nothing to do with the UI.
class MemorySection {

    private byte[] memory;
    private int baseAddress;
    private String[] logicalValueString;

    MemorySection(int base, int size) {

        baseAddress = base;

        memory = new byte[size];
        logicalValueString = new String[size];

        for (int i = 0; i < size; ++i) {

            memory[i] = (byte) 0;
            logicalValueString[i] = new String();
        }
    }

    public byte getAtAddress(int address) {

        return memory[address - baseAddress];
    }

    public String getLogicalValueAtAddress(int address) {

        return logicalValueString[address - baseAddress];
    }

    public void setAtAddress(int address, byte value) {

        memory[address - baseAddress] = value;
    }

    public void setLogicalValueAtAddress(int address, String s) {

        logicalValueString[address - baseAddress] = s;
    }

}

class MemoryViewTitlePanel extends Panel {

    MemoryViewTitlePanel () {

        setLayout(new GridLayout(1, 4));

        add(new Label("", Label.CENTER));
        add(new Label("address", Label.CENTER));
        add(new Label("bytecodes", Label.CENTER));
        add(new Label("mnemonics", Label.CENTER));
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}

class MemoryViewWithTitles extends Panel {

    private MemoryView memoryView = new MemoryView();

    MemoryViewWithTitles () {

        setLayout(new BorderLayout());

        add("North", new MemoryViewTitlePanel());
        add("Center", memoryView);
    }

    public MemoryView getMemoryViewReference(){

        return memoryView;
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}

// MemoryView is just used for the method area in this applet.  It implements the
// UI of the method area.
class MemoryView extends Panel {

    private final int memoryLocationsVisibleCount = 12;

    private Label[] pointer = new Label[memoryLocationsVisibleCount];
    private Label[] address = new Label[memoryLocationsVisibleCount];
    private Label[] byteValue = new Label[memoryLocationsVisibleCount];
    private Label[] logicalValue = new Label[memoryLocationsVisibleCount];

    MemoryView () {

        setLayout(new GridLayout(memoryLocationsVisibleCount, 4));

        setBackground(Color.lightGray);

        for (int i = memoryLocationsVisibleCount - 1; i >= 0; --i) {

            pointer[i] = new Label("", Label.RIGHT);
            add(pointer[i]);

            address[i] = new Label("", Label.CENTER);
            add(address[i]);

            byteValue[i] = new Label("", Label.CENTER);
            add(byteValue[i]);

            logicalValue[i] = new Label("", Label.LEFT);
            add(logicalValue[i]);
        }
    }

    public void setAt(int i, int addressValue, byte value, String logicalValueString) {

        HexString addressValueString = new HexString(addressValue, 8);
        HexString byteValueString = new HexString(value, 2);

        address[memoryLocationsVisibleCount - 1 - i].setText(addressValueString.getString());
        byteValue[memoryLocationsVisibleCount - 1 - i].setText(byteValueString.getString());
        logicalValue[memoryLocationsVisibleCount - 1 - i].setText(logicalValueString);
    }

    public void update(MemorySection memorySection, int initialAddress){

        for (int i = 0; i < memoryLocationsVisibleCount; ++i) {

            byte theByte = memorySection.getAtAddress(initialAddress + i);
            String logicalValue = memorySection.getLogicalValueAtAddress(
                initialAddress + i);
            setAt(i, initialAddress + i, theByte, logicalValue);
        }
    }

    public void clearPointers() {

        for (int i = 0; i < memoryLocationsVisibleCount; ++i) {
            pointer[i].setText("");
        }
    }

    public void updatePointer(int i, String pointerString) {

        pointer[memoryLocationsVisibleCount - 1 - i].setText(pointerString);
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}

class ControlPanel extends Panel {

    private TwoButtons leftButtonPanel;
    private ColoredLabel explanationLabel;

    ControlPanel() {

        setLayout(new BorderLayout(5, 5));

        leftButtonPanel = new TwoButtons("Step", "Reset");
        explanationLabel = new ColoredLabel("This is where the explanation goes...",
            Label.CENTER, Color.lightGray);

        setBackground(Color.blue);
        explanationLabel.setBackground(Color.lightGray);

        add("West", leftButtonPanel);
        add("Center", explanationLabel);
    }

    public void setExplanationText(String explanation) {

        explanationLabel.setLabelText(explanation);
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(5, 5, 5, 5);
    }
}

class TwoButtons extends Panel {

    private Button stepButton;
    private Button resetButton;

    TwoButtons(String top, String bottom) {

        setLayout(new GridLayout(2,1,0,5));

        stepButton = new Button(top);
        resetButton = new Button(bottom);

        add(stepButton);
        add(resetButton);
    }

    public Insets insets() {
        // top, left, bottom, right
        // put a 10 pixel separation between the two buttons and the explanation
        // area to the right.
        return new Insets(0, 0, 0, 0);
    }
}

class HexString {

    private final String hexChar = "0123456789abcdef";
    private StringBuffer buf = new StringBuffer();

    void Convert(int val, int maxNibblesToConvert) {

        buf.setLength(0);

        int v = val;
        for (int i = 0; i < maxNibblesToConvert; ++i) {

            if (v == 0) {

                if (i == 0) {
                    buf.insert(0, '0');
                }
                break;
            }

            // Get lowest nibble
            int remainder = v & 0xf;

            // Convert nibble to a character and insert it into the beginning of the string
            buf.insert(0, hexChar.charAt(remainder));

            // Shift the int to the right four bits
            v >>>= 4;
        }
    }

    HexString(int val, int minWidth) {

        Convert(val, minWidth);

        int charsNeeded = minWidth - buf.length();
        for (int i = 0; i < charsNeeded; ++i) {
            buf.insert(0, '0');
        }
    }

    public String getString() {

        return buf.toString();
    }
}

// StackMemorySection is just used for the stack in this applet. This implements
// the functionality of the stack and has nothing to do with the UI.
class StackMemorySection {

    private int[] memory;
    private int baseAddress;
    private String[] logicalValueString;

    StackMemorySection(int base, int size) {

        baseAddress = base;

        memory = new int[size];
        logicalValueString = new String[size];

        for (int i = 0; i < size; ++i) {

            memory[i] = 0;
            logicalValueString[i] = new String();
        }
    }

    public int getAtAddress(int address) {

        return memory[(address - baseAddress) / 4];
    }

    public String getLogicalValueAtAddress(int address) {

        return logicalValueString[(address - baseAddress) / 4];
    }

    public void setAtAddress(int address, int value) {

        memory[(address - baseAddress) / 4] = value;
    }

    public void setLogicalValueAtAddress(int address, String s) {

        logicalValueString[(address - baseAddress) / 4] = s;
    }

}

class StackMemoryViewTitlePanel extends Panel {

    StackMemoryViewTitlePanel () {

        setLayout(new GridLayout(1, 4));

        add(new Label("", Label.CENTER));
        add(new Label("address", Label.CENTER));
        add(new Label("word value", Label.CENTER));
        add(new Label("section", Label.CENTER));
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}

class StackMemoryViewWithTitles extends Panel {

    private StackMemoryView memoryView = new StackMemoryView();

    StackMemoryViewWithTitles () {

        setLayout(new BorderLayout());

        add("North", new StackMemoryViewTitlePanel());
        add("Center", memoryView);
    }

    public StackMemoryView getMemoryViewReference(){

        return memoryView;
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}

// StackMemoryView is just used for the stack in this applet.  It implements the
// UI of the stack.
class StackMemoryView extends Panel {

    private final int memoryLocationsVisibleCount = 8;

    private Label[] pointer = new Label[memoryLocationsVisibleCount];
    private Label[] address = new Label[memoryLocationsVisibleCount];
    private Label[] wordValue = new Label[memoryLocationsVisibleCount];
    private Label[] logicalValue = new Label[memoryLocationsVisibleCount];

    StackMemoryView () {

        setLayout(new GridLayout(memoryLocationsVisibleCount, 4));

        setBackground(Color.lightGray);

        for (int i = memoryLocationsVisibleCount - 1; i >= 0; --i) {

            pointer[i] = new Label("", Label.RIGHT);
            add(pointer[i]);

            address[i] = new Label("", Label.CENTER);
            add(address[i]);

            wordValue[i] = new Label("", Label.CENTER);
            add(wordValue[i]);

            logicalValue[i] = new Label("", Label.LEFT);
            add(logicalValue[i]);
        }
    }

    public void setAt(int i, int addressValue, int value, String logicalValueString) {

        HexString addressValueString = new HexString(addressValue, 8);
        HexString wordValueString = new HexString(value, 8);

        address[memoryLocationsVisibleCount - 1 - i].setText(addressValueString.getString());
        wordValue[memoryLocationsVisibleCount - 1 - i].setText(wordValueString.getString());
        logicalValue[memoryLocationsVisibleCount - 1 - i].setText(logicalValueString);
    }

    public void update(StackMemorySection memorySection, int initialAddress){

        for (int i = 0; i < memoryLocationsVisibleCount; ++i) {

            int theWord = memorySection.getAtAddress(initialAddress + (i * 4));
            String logicalValue = memorySection.getLogicalValueAtAddress(
                initialAddress + (i * 4));
            setAt(i, initialAddress + (i * 4), theWord, logicalValue);
        }
    }

    public void clearPointers() {

        for (int i = 0; i < memoryLocationsVisibleCount; ++i) {
            pointer[i].setText("");
        }
    }

    public void updatePointer(int i, String pointerString) {

        pointer[memoryLocationsVisibleCount - 1 - i].setText(pointerString);
    }

    public Insets insets() {
        // top, left, bottom, right
        return new Insets(0, 0, 0, 0);
    }
}
