package com.rowan.ruber;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;

import java.io.IOException;

public class Authenticator {

    public String authenticate(String authToken) {
        try {
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(Utils.convertStringToStream(Ids.FIREBASE_AUTH_KEY)))
                    .setDatabaseUrl("https://rowan-carpool.firebaseio.com")
                    .build();

            FirebaseApp.initializeApp(options);

            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(authToken);
            //String uid = decodedToken.getUid();

            return decodedToken.getName();
        } catch (FirebaseAuthException | IOException e) {
            // Invalid auth token
            return null;
        }
    }

}
