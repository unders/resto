# encoding: utf-8

require 'openssl'

module Resto
  module Request
    module Option

      def options
        @options ||= {}
      end

    begin :ssl_attributes

      def use_ssl(use_ssl=true)#
        tap do
          { :verify_mode => OpenSSL::SSL::VERIFY_PEER }.update(options)
          options.store(:use_ssl, use_ssl)
        end
      end

       # Sets the SSL version.  See OpenSSL::SSL::SSLContext#ssl_version=
      def ssl_version(ssl_version)#1.9
        tap { options.store(:ssl_version, ssl_version) }
      end

      # Sets an OpenSSL::PKey::RSA or OpenSSL::PKey::DSA object.
      # (This method is appeared in Michal Rokos's OpenSSL extension.)
      def key(key)#
        tap { options.store(:key, key) }
      end

      # Sets an OpenSSL::X509::Certificate object as client certificate.
      # (This method is appeared in Michal Rokos's OpenSSL extension).
      def cert(cert)#
        tap { options.store(:cert, cert) }
      end

      # Sets path of a CA certification file in PEM format.
      # The file can contain several CA certificates.
      def ca_file(ca_file)#
        tap { options.store(:ca_file, ca_file) }
      end

      # Sets path of a CA certification directory containing certifications in
      # PEM format.
      def ca_path(ca_path)#
        tap { options.store(:ca_path, ca_path) }
      end

      # Sets the X509::Store to verify peer certificate.
      def cert_store(cert_store)#
        tap { options.store(:cert_store, cert_store) }
      end

      # Sets the available ciphers.  See OpenSSL::SSL::SSLContext#ciphers=
      def ciphers(ciphers) # 1.9
        tap { options.store(:ciphers, ciphers) }
      end

      # Sets the flags for server the certification verification at beginning of
      # SSL/TLS session.
      #
      # OpenSSL::SSL::VERIFY_NONE or OpenSSL::SSL::VERIFY_PEER are acceptable.
      def verify_mode(verify_mode)#
        tap { options.store(:verify_mode, verify_mode) }
      end

      def verify_none
        tap { verify_mode(OpenSSL::SSL::VERIFY_NONE) }
      end

      def verify_peer
        tap { verify_mode(OpenSSL::SSL::VERIFY_PEER) }
      end

      # Sets the verify callback for the server certification verification.
      def verify_callback(verify_callback)#
        tap { options.store(:verify_callback, verify_callback)}
      end

      def verify_depth(verify_depth)#
        tap { options.store(:verify_depth, verify_depth)}
      end

      # Sets the SSL timeout seconds.
      def ssl_timeout(ssl_timeout)#
        tap { options.store(:ssl_timeout, ssl_timeout)}
      end
    end #:ssl_attributes

      def close_on_empty_response(close_on_empty_response)#
        tap { options.store(:close_on_empty_response, close_on_empty_response) }
      end

      # Number of seconds to wait for the connection to open.
      # If the HTTP object cannot open a connection in this many seconds,
      # it raises a TimeoutError exception.
      def open_timeout(time)#
        tap { options.store(:open_timeout, time)}
      end

      # Number of seconds to wait for one block to be read (via one read(2) call).
      # If the HTTP object cannot read data in this many seconds,
      # it raises a TimeoutError exception.
      def read_timeout(time)#
        tap { options.store(:read_timeout, time)}
      end

      #Seconds to wait until reading one block (by one read(2) call).
      def timeout(timeout) # 1.8.7 1.9??
        tap { options.store(:timeout, timeout)}
      end

      # *WARNING* This method opens a serious security hole.
      # Never use this method in production code.
      #
      # Sets an output stream for debugging.
      #
      #   Resto.url('www.google.com').set_debug_output($stderr).get
      def set_debug_output(output)
        tap { options.store(:set_debug_output, output)}
      end
    end
  end
end
