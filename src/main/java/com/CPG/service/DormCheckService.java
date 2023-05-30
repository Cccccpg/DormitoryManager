package com.CPG.service;

import com.CPG.domain.DormCheck;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.List;

public interface DormCheckService {
    List<DormCheck> findAll(int page, int size) throws Exception;

    List<DormCheck> search(int page, int size, String keyword) throws Exception;

    void add(DormCheck dormCheck) throws Exception;

    void update(DormCheck dormCheck) throws Exception;

    InputStream getInputStream() throws Exception;

    DormCheck findByDormId(String dorm_id) throws Exception;

    DormCheck findByDormLeader(String dorm_leader) throws Exception;

    DormCheck findByCheckDate(String dorm_checkdate) throws Exception;

    DormCheck findById(String id) throws Exception;

    List<DormCheck> findByLeader(String leader) throws Exception;

    boolean insert(DormCheck dormCheck) throws Exception;

//    String ajaxUploadExcel(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
