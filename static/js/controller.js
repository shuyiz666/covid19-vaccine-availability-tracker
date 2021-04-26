function gettime()
{
  $.ajax(
      {
        url: "/time",
        timeout: 10000, // 超时时间设置为 10 秒
        success: function (data)
        {
          $("#tim").html(data)
        },
        error: function ()
        {

        }

      });
}

function shaws_star()
{
  $.ajax(
      {
        url: "/shaws_star",
        success: function (data)
        {
          ec_left_top_option.series[0].data = data.data
          ec_left_top.setOption(ec_left_top_option)
        },
        error: function ()
        {
        }
      }
  );
}

function store_ava()
{
  $.ajax(
      {
        url: "/store_ava",
        success: function (data)
        {
          ec_left_bottom_option.series[0].data = data.star
          ec_left_bottom_option.series[1].data = data.shaws
          ec_left_bottom.setOption(ec_left_bottom_option)
        },
        error: function ()
        {
        }
      }
  );
}

function city()
{
    $.ajax(
      {
        url: "/city",
        dataType:'json',
        success: function (data)
        {
          $('#city').DataTable({
            "data": data.data,
            "columns": [
                { "data": "city" },
                { "data": "available" },
                { "data": "total" },
                { "data": "available rate (%)" }
            ],
            "order": [[ 3, "desc" ]]
          })
        },
        error: function ()
        {
        }
      }
    );
}


gettime();
shaws_star();
store_ava();
city();
