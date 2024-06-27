// HttpUtilTest.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "./../public/include/HttpUtil/HttpUtil.h"
#include <string>
#include <iostream>
//#include <Windows.h>

using namespace httpUtil;

std::string szUrl = "https://10.188.0.101:443/artemis/api/resource/v1/regions";
//std::string szBody = "{\"cameraIndexCode\":\"b79c98bce8a344beb90a1f6912529d21\"}";
std::string szBody = "{\"pageNo\": 1,\"pageSize\": 20}";
std::string appkey = "26395532";
std::string secret = "mDXrfXuGRzNW0aqUkzgD";


int main()
{	
	int dataLen = 0;
	char* data = HTTPUTIL_Post(szUrl.c_str(), szBody.c_str(), appkey.c_str(), secret.c_str(), 15, &dataLen);
	if (NULL == data)
	{
		std::cout << "HttpPost fail, status is " << HTTPUTIL_GetLastStatus() << std::endl;
	}
	else
	{
		std::string rsp = std::string(data, dataLen);		
		std::cout << rsp << std::endl;
		HTTPUTIL_Free(data);
	}
	
    return 0;
}

