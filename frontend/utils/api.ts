import axios from 'axios';
import toast from "react-hot-toast";

type HeadersObject = Record<string, string>;

async function request(
    method: string,
    serviceUrl: string,
    endpoint: string,
    data?: any,
    headers: HeadersObject = {}
): Promise<any> {
  const url = `${serviceUrl}${endpoint}`;

  try {
    const config = {
      method,
      url,
      headers,
      withCredentials: true,
      data,
    };

    if (data instanceof FormData) {
      if (config.headers['Content-Type']) {
        delete config.headers['Content-Type'];
      }
    } else {
      if (!config.headers['Content-Type']) {
        config.headers['Content-Type'] = 'application/json';
      }
    }

    const response = await axios.request(config);

    return response.data;
  } catch (error: any) {
    if (axios.isAxiosError(error)) {
      const status = error.response?.status;
      const message =
          error.response?.data?.error_fa ||
          error.response?.data?.message ||
          error.response?.statusText ||
          error.message ||
          'API error';

      // Show default toast messages for common HTTP status codes
      switch (status) {
        case 403:
          toast.error("Forbidden: You don't have permission to perform this action.");
          break;
        case 423:
          toast.error("Locked! Please contact support");
          break;
        case 503:
          toast.error("Service unavailable!");
          break;
        default:
          toast.error(message || "An unexpected error occurred.");
          break;
      }

      throw new Error(`API error (${status}): ${message}`);
    } else {
      toast.error("Network error: Please check your internet connection.");
      throw error;
    }
  }
}


export function get(serviceUrl: string, endpoint: string, headers?: HeadersObject) {
  return request('GET', serviceUrl, endpoint, undefined, headers);
}

export function post(serviceUrl: string, endpoint: string, data?: any, headers?: HeadersObject) {
  return request('POST', serviceUrl, endpoint, data, headers);
}

export function postFormData(serviceUrl: string, endpoint: string, formData: FormData, headers?: HeadersObject) {
  return request('POST', serviceUrl, endpoint, formData, headers);
}

export function put(serviceUrl: string, endpoint: string, data?: any, headers?: HeadersObject) {
  return request('PUT', serviceUrl, endpoint, data, headers);
}

export function patch(serviceUrl: string, endpoint: string, data?: any, headers?: HeadersObject) {
  return request('PATCH', serviceUrl, endpoint, data, headers);
}

export function del(serviceUrl: string, endpoint: string, data?: any, headers?: HeadersObject) {
  return request('DELETE', serviceUrl, endpoint, data, headers);
}