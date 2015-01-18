package com.jonnolen.viperj2objc.test;

import com.jonnolen.viperj2objc.HelloWorldPrinter;
import com.jonnolen.viperj2objc.PresenterThingaMajig;
import org.junit.Test;

import static org.mockito.Mockito.*;

public class PrintsHelloWorld {
    @Test
    public void happyPath() throws Exception {
        HelloWorldPrinter printer = mock(HelloWorldPrinter.class);

        new PresenterThingaMajig(printer).doMessageThing();

        verify(printer).printHelloWorld();
    }

}
