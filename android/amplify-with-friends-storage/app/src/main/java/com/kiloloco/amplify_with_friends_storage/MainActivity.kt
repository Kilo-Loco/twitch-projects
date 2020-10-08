package com.kiloloco.amplify_with_friends_storage

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        galleryButton.setOnClickListener {
            Log.i("kilo", "gallery")
//            this.openGallery()
        }
        uploadButton.setOnClickListener {
            Log.i("kilo", "upload")
//            this.uploadPhoto()
        }
        downloadButton.setOnClickListener {
            Log.i("kilo", "download")
//            this.downloadPhoto()
        }

    }
}