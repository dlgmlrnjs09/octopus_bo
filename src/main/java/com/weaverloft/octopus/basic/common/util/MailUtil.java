package com.weaverloft.octopus.basic.common.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-10
 */
@Component
public class MailUtil {
    private static JavaMailSender jms;

    @Autowired
    private MailUtil(JavaMailSender j) {
        jms = j;
    }

    public static boolean sendMail(String to, String from, String subject, String content) {
        boolean isSuccess = true;
        try {
            MimeMessage message = jms.createMimeMessage();

            message.addRecipients(MimeMessage.RecipientType.TO, to);// 보내는 대상
            message.setSubject(subject);// 제목
            message.setText(content, "utf-8", "html");// 내용
            message.setFrom(new InternetAddress(from, from));// 보내는 사람
            jms.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false;
        }

        return isSuccess;
    }
}
