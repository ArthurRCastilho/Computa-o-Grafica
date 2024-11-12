package org.example;
import static org.lwjgl.glfw.GLFW.*;
import static org.lwjgl.opengl.ARBVertexArrayObject.glBindVertexArray;
import static org.lwjgl.opengl.ARBVertexArrayObject.glGenVertexArrays;
import static org.lwjgl.opengl.GL.*;
import static org.lwjgl.opengl.GL20.*;
//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        float[]vertices = {
                -0.5f, -0.5f,0.0f,
                0.5f, -0.5f,0.0f,
                0.0f, 0.5f,0.0f,
        };
        if(!glfwInit()) {
            throw new IllegalStateException("Unable to initialize GLFW");
        }
        glfwWindowHint(GLFW_MAXIMIZED, GLFW_TRUE);
        glfwWindowHint(GLFW_TRANSPARENT_FRAMEBUFFER, GLFW_TRUE);
        /// glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GLFW_TRUE);

        long nativeWindow = glfwCreateWindow(1280,720,"Software do cauazin",0,0);
        glfwMakeContextCurrent(nativeWindow);

        createCapabilities();

        int VAO = glGenVertexArrays();
        glBindVertexArray(VAO);
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(0,3,GL_FLOAT,false,3*Float.BYTES,0);

        int VBO = glGenBuffers();
        glBindBuffer(GL_ARRAY_BUFFER, VBO);
        glBufferData(GL_ARRAY_BUFFER, vertices, GL_STATIC_DRAW);

        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindVertexArray(0);

        while(!glfwWindowShouldClose(nativeWindow)) {
            glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
            glClear(GL_COLOR_BUFFER_BIT);



            glfwSwapBuffers(nativeWindow);
            glfwPollEvents();
        }
    }
}