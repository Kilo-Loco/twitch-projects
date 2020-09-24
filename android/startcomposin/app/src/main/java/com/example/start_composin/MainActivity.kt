package com.example.start_composin

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.animation.expandHorizontally
import androidx.compose.foundation.*
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.ColumnScope.align
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.res.dimensionResource
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.unit.dp
import androidx.ui.tooling.preview.Preview
import com.example.start_composin.ui.StartcomposinTheme

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            StartcomposinTheme {
                // A surface container using the 'background' color from the theme
                Surface(color = MaterialTheme.colors.background) {
                    layoutController()
                }
            }
        }
    }

    @Composable
    fun myNavBar(title: String) {
        TopAppBar(title = { Text(title, color = Color.White) }, backgroundColor = Color(0xFFA47BE4))
    }

    @Composable
    fun LoginView() {
        Scaffold(
            topBar = { myNavBar("Login") }
        ) {

            Surface(
                modifier = Modifier.fillMaxSize()
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    val usernameState = remember { mutableStateOf(TextFieldValue()) }
                    val passwordState = remember { mutableStateOf(TextFieldValue()) }

                    TextField(
                        value = usernameState.value,
                        onValueChange = { usernameState.value = it },
                        placeholder = { Text("Username") },
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 16.dp, vertical = 4.dp)
                    )

                    TextField(
                        value = passwordState.value,
                        onValueChange = { passwordState.value = it },
                        visualTransformation = PasswordVisualTransformation(),
                        keyboardType = KeyboardType.Password,
                        placeholder = { Text("Password") },
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(horizontal = 16.dp, vertical = 4.dp)
                    )

                    Button(
                        onClick = {  Log.i("kyle", "u: ${usernameState.value.text} p: ${passwordState.value.text}") }
                    ) {
                        Text("Sign In")
                    }
                }
            }
        }
    }

    @Preview(showBackground = true)
    @Composable
    fun layoutController() {
        Box(
            gravity = ContentGravity.Center,
            modifier = Modifier
                .background(color = Color.White)
                .fillMaxSize()
        ) {
            Column() {
                TextField(value = "", onValueChange = {}, placeholder = { Text("username") })
                TextField(value = "", onValueChange = {}, placeholder = { Text("password") })
            }

        }

    }


}

