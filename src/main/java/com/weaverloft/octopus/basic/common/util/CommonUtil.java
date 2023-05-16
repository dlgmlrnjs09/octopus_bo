package com.weaverloft.octopus.basic.common.util;

import org.apache.commons.lang.RandomStringUtils;

import java.util.Random;

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
}
