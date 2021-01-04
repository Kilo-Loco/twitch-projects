package com.kiloloco.nav_and_json

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumnFor
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.*
import com.google.gson.Gson
import com.kiloloco.nav_and_json.ui.NavandjsonTheme

data class User(val id: Int, val name: String) {
    val description: String
        get() = "$name has an ID of $id"
}

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            NavandjsonTheme {
                AppNavigator()
            }
        }
    }

    @Composable
    fun AppNavigator() {
        val navController = rememberNavController()

        NavHost(navController = navController, startDestination = "usersView") {
            composable("usersView") {
                UsersView(navController = navController, users = listOf(
                    User(1, "kyle"),
                    User(2, "kilo"),
                    User(3, "kappa")
                ))
            }

            composable(
                    "userDetailsView/{userJson}",
                    arguments = listOf(
                            navArgument("userJson") { type = NavType.StringType }
                    )
            ) { backStackEntry ->
                backStackEntry?.arguments?.getString("userJson")?.let { json ->
                    val user = Gson().fromJson(json, User::class.java)
                    UserDetailsView(user = user)
                }
            }
        }
    }
}

@Composable
fun UsersView(navController: NavHostController, users: List<User>) {

    fun navigateToUser(user: User) {
        val userJson = Gson().toJson(user)
        navController.navigate("userDetailsView/$userJson")
    }

    LazyColumnFor(items = users) { user ->
        Card(
                elevation = 8.dp,
                modifier = Modifier
                        .padding(8.dp, 4.dp)
                        .clickable(onClick = { navigateToUser(user) })
        ) {
            ListItem(text = { Text(user.name) })
        }
    }
}

@Composable
fun UserDetailsView(user: User) {
    Box(contentAlignment = Alignment.Center, modifier = Modifier.fillMaxSize()) {
        Text(user.description)
    }

}



















