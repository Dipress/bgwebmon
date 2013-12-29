# coding: utf-8
class DialupipSerializer < ActiveModel::Serializer
  attributes :id, :human_ip, :status_class

  def status_class
    cmd="rrdtool fetch /var/www/graphs/#{object.human_ip.gsub(/\./,"")}.rrd AVERAGE -r 300 -s -120"
    rxtx=`#{cmd}`
    if rxtx != "" && !rxtx.nil?
      rxtx=rxtx.gsub(/[0-9].+\:.+/).first.gsub(/[0-9]+\:\ /, "")
      if rxtx =~ /-nan/
        return 'danger'
      else
        return 'success'
      end
    else
      return 'danger'
    end
  end
end