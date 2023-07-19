package com.weaverloft.octopus.configuration;

import com.weaverloft.octopus.basic.member.service.MembershipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@Configuration
@EnableScheduling
public class Scheduler {

    @Autowired
    MembershipService membershipService;

    //@Scheduled(cron = "0 05 13 * * *")
    public void testMethod(){
        System.out.println("@@@@@ test_shceduled");
    }

    @Scheduled(cron = "0 00 01 * * *")
    public void updateMembershipSeq() {
        membershipService.updateMembershipSeq();
    }
}
