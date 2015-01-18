package com.jonnolen.viperj2objc;

public class PresenterThingaMajig {
    private final HelloWorldPrinter printer;

    public PresenterThingaMajig(HelloWorldPrinter printer) {
        this.printer = printer;
    }

    public void doMessageThing() {
        printer.printHelloWorld();
    }
}
