package org.zerock.controller;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


//cron �����ٷ� Ŭ�������� �����ϴ� ������̼�.
@Component
public class Scheduler {
// cron �������� �����ٷ��� ����Ǵ� �ֱ⸦ ����.(�Ʒ��� cron ������ ������ �ڼ��� ����)
@Scheduled(cron = "*/10 * * * * *")
public void run() {
//	System.out.println("cron test!!");
	}
}


