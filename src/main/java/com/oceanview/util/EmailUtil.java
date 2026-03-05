package com.oceanview.util;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    private static final String SMTP_SERVER = "smtp.gmail.com";
    private static final String USERNAME = "your_email@gmail.com"; // Provide a valid email for real testing
    private static final String PASSWORD = "your_app_password";

    public static void sendConfirmationEmail(String toEmail, String resNumber, String guestName) {
        // Run in a new thread so it doesn't block the UI
        new Thread(() -> {
            Properties prop = new Properties();
            prop.put("mail.smtp.host", SMTP_SERVER);
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true"); // TLS

            Session session = Session.getInstance(prop,
                    new javax.mail.Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(USERNAME, PASSWORD);
                        }
                    });

            try {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(USERNAME));
                message.setRecipients(
                        Message.RecipientType.TO,
                        InternetAddress.parse(toEmail));
                message.setSubject("Ocean View Resort - Booking Confirmation");
                message.setText("Dear " + guestName + ",\n\n"
                        + "Thank you for choosing Ocean View Resort. Your booking has been confirmed.\n"
                        + "Your Reservation Number is: " + resNumber + "\n\n"
                        + "We look forward to hosting you.\n\n"
                        + "Best Regards,\nOcean View Resort Team");

                Transport.send(message);

                System.out.println("Email sent successfully to " + toEmail);

            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }).start();
    }
}
