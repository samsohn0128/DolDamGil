package com.spidycoder.doldamgilserver;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.Date;

//@RestController
//@ControllerAdvice(assignableTypes = {GymController.class})
//public class GymResponseEntityExceptionHandler extends ResponseEntityExceptionHandler {
//    @ExceptionHandler(GymNotFoundException.class)
//    public final ResponseEntity<Object> handleGymNotFoundException(Exception exc, WebRequest request) {
//        ExceptionResponse exceptionResponse =
//                new ExceptionResponse(new Date(), exc.getMessage(), request.getDescription(false));
//        return new ResponseEntity<>(exceptionResponse, HttpStatus.NOT_FOUND);
//    }
//}
