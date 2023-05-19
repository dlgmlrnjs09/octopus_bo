package com.weaverloft.octopus.basic.common.util;

import org.apache.commons.lang.RandomStringUtils;

import java.util.Arrays;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author note-gram-015
 * @version 0.0.1
 * @brief 간략
 * @details 상세
 * @date 2023-04-11
 */
public class CommonUtil {

    /**
    *  @brief 전달받은 파라미터들의 null 또는 빈 값 여부 체크
    *  @date 2023-04-11
    *  @return boolean(null 또는 빈 값 여부)
    *  @param obj : 검증할 객체 (가변길이인자)
    */
    public static boolean isEmpty(Object... obj) {
        for (Object o : obj) {
            if (null == o || "".equals(o)) {
                return true;
            }
        }
        return false;
    }

    /**
     *  @brief 전달받은 boolean 파라미터 중 하나라도 true면 true 반환
     *  @date 2023-04-11
     *  @return boolean(true 값 존재 여부)
     *  @param obj : 검증할 객체 (가변길이인자)
     */
    public static boolean isTrueOneThing(boolean... obj) {
        for (boolean o : obj) {
            if (o) {
                return true;
            }
        }
        return false;
    }

    /**
    *  @brief 랜덤한 8자리의 인증코드 반환(영문,숫자)
    *  @date 2023-04-12
    *  @return String(인증코드)
    *  @param
    */
    public static String createStringSecureKey() {
        StringBuilder key = new StringBuilder();
        Random rnd = new Random();

        for (int i = 0; i < 8; i++) { // 인증코드 8자리
            int index = rnd.nextInt(3); // 0~2 까지 랜덤, rnd 값에 따라서 아래 switch 문이 실행됨

            switch (index) {
                case 0:
                    key.append((char) ((int) (rnd.nextInt(26)) + 97));
                    // a~z (ex. 1+97=98 => (char)98 = 'b')
                    break;
                case 1:
                    key.append((char) ((int) (rnd.nextInt(26)) + 65));
                    // A~Z
                    break;
                case 2:
                    key.append((rnd.nextInt(10)));
                    // 0~9
                    break;
            }
        }

        return key.toString();
    }

    /**
    *  @brief 랜덤한 6자리의 인증코드 반환(숫자)
    *  @date 2023-04-13
    *  @return String(인증코드)
    *  @param
    */
    public static String createNumberSecureKey() {
        return RandomStringUtils.randomNumeric(6);
    }

    /**
     *  @brief 개인정보 마스킹(성명)
     *  @date 2023-05-19
     *  @return String(마스킹 값)
     *  @param
     */
    public static String maskingName(String name) {
        int maskingCount = 0;
        String masking = "";
        String splitName = "";
        name = name.trim();

        if (!CommonUtil.isEmpty(name)) {
            String trimName = name.trim().replaceAll(" ", "");
            String firstName = name.substring(0, 1);
            String lastName = name.substring(trimName.length() - 1);

            // 내국인
            if (Pattern.matches("^[ㄱ-ㅎ가-힣]*$", trimName)) {
                // 외자
                if (trimName.length() == 2) {
                    name = firstName + "*";
                } else {
                    maskingCount = name.length() - 2;

                    for (int i = 0; i < maskingCount; i++) {
                        masking += "*";
                    }
                    name = firstName + masking + lastName;
                }

            } else {
                // 외국인 (5번째부터 마스킹)
                if (name.length() >= 5) {
                    splitName = name.substring(0, 4);
                    maskingCount = name.length() - splitName.length();
                    for (int i = 0; i < maskingCount; i++) {
                        masking += "*";
                    }
                    name = splitName + masking;
                }
            }
        }

        return name;

    }

    /**
     *  @brief 개인정보 마스킹(주소)
     *  @date 2023-05-19
     *  @return String(마스킹 값)
     *  @param
     */
    //주소 숫자만 마스킹
    public static String maskingAddr(String addr) {

        String result = "";
        addr = addr.trim();

        if (!CommonUtil.isEmpty(addr)) {
            result = addr.replaceAll("[0-9]", "*");
        }

        return result;
    }

    /**
     *  @brief 개인정보 마스킹(전화번호)
     *  @date 2023-05-19
     *  @return String(마스킹 값)
     *  @param
     */
    // 가운데 숫자 4자리 마스킹 '-'의 여부 상관없이 마스킹 처리
    public static String maskingPhone(String userPhone) {

        userPhone = userPhone.trim();

        if(!CommonUtil.isEmpty(userPhone)) {
            String regex = "(\\d{2,3})-?(\\d{3,4})-?(\\d{4})$";

            Matcher matcher = Pattern.compile(regex).matcher(userPhone);
            if(matcher.find()) {
                String target = matcher.group(2);
                int length = target.length();
                char[] c = new char[length];
                Arrays.fill(c, '*');

                return userPhone.replace(target, String.valueOf(c));
            }
        }

        return userPhone;
    }
}
