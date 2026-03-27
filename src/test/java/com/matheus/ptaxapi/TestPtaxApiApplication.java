package com.matheus.ptaxapi;

import org.springframework.boot.SpringApplication;

public class TestPtaxApiApplication {

	public static void main(String[] args) {
		SpringApplication.from(PtaxApiApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
