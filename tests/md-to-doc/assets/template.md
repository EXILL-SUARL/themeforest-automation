# {{title}}

{% for user in users -%}
- [{{ user.username }} likes {% for color in user.fav_colors -%}{{ color }} {% endfor %}]({{ user.url }})
{% endfor %}
