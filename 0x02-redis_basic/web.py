#!/usr/bin/env python3
"""
This module defines the get_page function to
fetch and cache HTML content from a URL.
"""

import requests
import redis
from typing import Callable
from functools import wraps


def cache_with_expiry(expiry: int) -> Callable:
    """
    Decorator to cache the result of a
    function call with a specified expiry time.

    Args:
        expiry (int): Expiry time in seconds.

    Returns:
        Callable: The decorated function.
    """
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(url: str) -> str:
            r = redis.Redis()
            cache_key = f"cache:{url}"
            count_key = f"count:{url}"

            # Increment the access count
            r.incr(count_key)

            # Try to get cached result
            cached_result = r.get(cache_key)
            if cached_result:
                return cached_result.decode('utf-8')

            # If not cached, fetch the content
            result = func(url)
            r.setex(cache_key, expiry, result)
            return result

        return wrapper
    return decorator


@cache_with_expiry(10)
def get_page(url: str) -> str:
    """
    Fetch HTML content from a URL and cache it.

    Args:
        url (str): The URL to fetch content from.

    Returns:
        str: The HTML content of the URL.
    """
    response = requests.get(url)
    return response.text


if __name__ == "__main__":
    url = "http://slowwly.robertomurray.co.uk"
    print(get_page(url))
    print(get_page(url))
    print(get_page(url))
